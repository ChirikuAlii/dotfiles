import os
import subprocess
import json
import sys
import tty
import termios
import argparse
from dataclasses import dataclass
import socket


@dataclass
class Workspaces:
    id: int
    name: str


@dataclass
class Window:
    id: int
    app_id: str
    workspace: Workspaces | None = None


@dataclass
class Target:
    app_id: str
    workspace_name: str
    key: str
    command_open: str | None = None


def main():

    # Get Argument
    parser = argparse.ArgumentParser(description="Read Arument")
    parser.add_argument(
        "-ws",
        type=str,
        help="Put workspace name from niri config -w '1'",
        required=True,
    )
    args = parser.parse_args()

    print("Masukkan satu karakter (misal: 1, q, atau a): ")

    # Get Input Key
    key = get_input_keyboard()
    workspace_argument = args.ws

    print(f"Workspace argument {workspace_argument}")
    print(
        f"\rInput yang diterima: {key}"
    )  # \r untuk kembali ke awal baris setelah mode raw

    list_target: list[Target] = [
        Target(
            app_id="com.mitchellh.ghostty",
            command_open="ghostty",
            workspace_name="Terminal",
            key="a",
        ),
        Target(app_id="app.zen_browser.zen", workspace_name="Browser", key="a"),
        Target(
            app_id="google-chrome",
            command_open="com.google.Chrome",
            workspace_name="Browser",
            key="s",
        ),
        Target(app_id="firefox", workspace_name="Browser", key="d"),
        Target(app_id="code", workspace_name="Code", key="a"),
        Target(
            app_id="Windsurf", command_open="windsurf", workspace_name="Code", key="s"
        ),
        Target(
            app_id="bruno",
            command_open="com.usebruno.Bruno",
            workspace_name="Tools",
            key="s",
        ),
        Target(
            app_id="sublime_merge",
            command_open="/opt/sublime_merge/sublime_merge",
            workspace_name="Tools",
            key="a",
        ),
        Target(
            app_id="org.telegram.desktop",
            command_open="Telegram",
            workspace_name="Mail",
            key="d",
        ),
        Target(app_id="discord", workspace_name="Mail", key="s"),
        Target(
            app_id="org.mozilla.Thunderbird",
            command_open="thunderbird",
            workspace_name="Mail",
            key="a",
        ),
        Target(app_id="com.mitchellh.ghostty.note", workspace_name="Note", key="a"),
        Target(app_id="obsidian", workspace_name="Note", key="s"),
        Target(
            app_id="Spotify",
            command_open="com.spotify.Client",
            workspace_name="Media",
            key="a",
        ),
        Target(app_id="vlc", workspace_name="Media", key="s"),
        Target(app_id="thunar", workspace_name="File", key="a"),
        Target(app_id="", workspace_name="", key=""),
        Target(app_id="", workspace_name="", key=""),
        Target(app_id="", workspace_name="", key=""),
        Target(app_id="", workspace_name="", key=""),
        Target(app_id="", workspace_name="", key=""),
        Target(app_id="", workspace_name="", key=""),
    ]
    # list app id
    list_windows = subprocess.run(["niri", "msg", "-j", "windows"], capture_output=True)
    list_windows = json.loads(list_windows.stdout)
    list_workspace = get_list_workspace()

    print(f"list window: {list_windows}")
    print(f"list_workspace: {list_workspace}")
    if key in ("\r", "\n"):
        subprocess.run(["niri", "msg", "action", "focus-workspace", f"File"])
    for target in list_target:
        if key == target.key and workspace_argument == target.workspace_name:
            go_to_target_window(
                target=target,
                list_workspace=list_workspace,
                list_windows=list_windows,
            )
            break


def get_input_keyboard():
    # Simpan pengaturan terminal lama
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        # Ubah terminal ke mode raw (bisa baca per karakter)
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        # Kembalikan pengaturan terminal ke semula
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch


def get_list_workspace():
    # connect socket
    niri_socket = os.environ.get("NIRI_SOCKET")

    if not niri_socket:
        raise RuntimeError("NIRI_SOCKET not set")

    # buat koneksi UNIX socket
    client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    client.connect(niri_socket)

    # kirim request
    request = {"Workspaces": None}
    client.sendall((json.dumps(request) + "\n").encode())

    # terima response
    response = b""
    while b"\n" not in response:
        chunk = client.recv(4096)
        if not chunk:
            break
        response += chunk

    client.close()

    data = json.loads(response.decode())
    workspaces = data.get("Ok", {}).get("Workspaces", [])
    result = [{"id": w["id"], "name": w["name"]} for w in workspaces]
    print(f"list active workspace:{result}")
    # return Workspaces(result)
    return result


def go_to_target_window(target: Target, list_windows, list_workspace):
    app_id = target.app_id
    list_filtered_window: list[Window] = []
    for window in list_windows:
        if window["app_id"] == app_id:
            for workspace in list_workspace:
                if workspace["name"] == target.workspace_name:
                    list_filtered_window.append(
                        Window(
                            id=window["id"],
                            app_id=window["app_id"],
                            workspace=Workspaces(
                                id=window["workspace_id"], name=workspace["name"]
                            ),
                        )
                    )

    print(f"hasil filter: {list_filtered_window}")
    if list_filtered_window:
        # niri msg action focus-window --id
        subprocess.run(
            [
                "niri",
                "msg",
                "action",
                "focus-window",
                "--id",
                f"{list_filtered_window[0].id}",
            ]
        )
    else:

        subprocess.run(
            [
                "niri",
                "msg",
                "action",
                "spawn",
                "--",
                f"{target.command_open if target.command_open else target.app_id}",
            ]
        )


if __name__ == "__main__":
    main()
