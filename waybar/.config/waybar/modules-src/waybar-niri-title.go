package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os/exec"
	s "strings"
)

type NiriEvent struct {
	WindowChanged         *WindowChanged         `json:"WindowsChanged"`
	WindowFocusChanged    *WindowFocusChanged    `json:"WindowFocusChanged"`
	WindowOpenedOrChanged *WindowOpenedOrChanged `json:"WindowOpenedOrChanged"`
	WindowClosed          *WindowClosed          `json:"WindowClosed"`
	WorkspaceActivated    *WorkspaceActivated    `json:"WorkspaceActivated"`
}

// WindowOpenedOrChanged
// { window : {app_id : "com.xx.ghostty"} }

type WindowOpenedOrChanged struct {
	Window Window `json:"window"`
}

type Window struct {
	ID    int    `json:"id"`
	AppID string `json:"app_id"`
}

//WindowFocusChanged
// {id : 4 } jika null abaikan

type WindowFocusChanged struct {
	ID int `json:"id"`
}

//WindowClosed
// {id : 22} flag untuk focus changed

type WindowClosed struct {
	ID int `json:"id"`
}

//WindowsChanged
//windows: [{id : 2 ,app_id: "xx.aaa.app", isFocused:true}]

type WindowChanged struct {
	ID      int       `json:"id"`
	Windows []Windows `json:"windows"`
}

type Windows struct {
	ID        int    `json:"id"`
	AppID     string `json:"app_id"`
	IsFocused bool   `json:"is_focused"`
}

//WorkspaceActivated
//{id : 3} (abaikan responsenya) flag untuk focus changed

type WorkspaceActivated struct {
	ID int `json:"id"`
}

func main() {
	cmd := exec.Command("niri", "msg", "-j", "event-stream")

	stdout, err := cmd.StdoutPipe()
	cmd.Start()
	if err != nil {
		log.Fatal(err)
	}

	decoder := json.NewDecoder(stdout)

	windowsData := make(map[int]Windows)
	isShowEmptyOutput := false
	for {
		var event NiriEvent
		if err := decoder.Decode(&event); err != nil {
			if err == io.EOF {
				break
			}
			continue
		}
		switch {
		case event.WindowChanged != nil:
			//ambil yang active saja dan output kan
			for _, window := range event.WindowChanged.Windows {
				windowsData[window.ID] = window
				if window.IsFocused {
					fmt.Println("" + splitAppIDTakeLastIndexOnly(window.AppID))
				}
			}

		case event.WindowFocusChanged != nil:
			//ambil id nya dan cocok kan dgn windowsData dan output kan

			if windowsData[event.WindowFocusChanged.ID].AppID != "" {
				fmt.Println(splitAppIDTakeLastIndexOnly(windowsData[event.WindowFocusChanged.ID].AppID))
			} else if isShowEmptyOutput {
				fmt.Println(splitAppIDTakeLastIndexOnly(windowsData[event.WindowFocusChanged.ID].AppID))

				isShowEmptyOutput = false
			}

		case event.WindowOpenedOrChanged != nil:
			//ambil data nya and masukkan ke data window changed
			windowsData[event.WindowOpenedOrChanged.Window.ID] = Windows{
				AppID: event.WindowOpenedOrChanged.Window.AppID,
				ID:    event.WindowOpenedOrChanged.Window.ID,
			}

			if windowsData[event.WindowOpenedOrChanged.Window.ID].AppID != "" {
				fmt.Println(splitAppIDTakeLastIndexOnly(windowsData[event.WindowOpenedOrChanged.Window.ID].AppID))
			} else if isShowEmptyOutput {

				fmt.Println(splitAppIDTakeLastIndexOnly(windowsData[event.WindowOpenedOrChanged.Window.ID].AppID))
				isShowEmptyOutput = false
			}
		case event.WindowClosed != nil:
			//ambil datanya dan hapus
			isShowEmptyOutput = true
			if isShowEmptyOutput {
				fmt.Println("")
			}
			delete(windowsData, event.WindowClosed.ID)

		case event.WorkspaceActivated != nil:
			//ambil datanya dan hapus
			isShowEmptyOutput = true
			if isShowEmptyOutput {
				fmt.Println("")
			}
		}

	}

	if err := cmd.Wait(); err != nil {
		log.Fatal(err)
	}
}

func splitAppIDTakeLastIndexOnly(input string) string {

	if input == "" {
		return input
	}
	//lakukan split string berdasarkan .
	parts := s.Split(input, ".")

	//ambil hasil split terakhir itu berada di index mana
	lastIndexResultSplit := len(parts) - 1
	lastValueFromSplit := parts[lastIndexResultSplit]

	//ambil first letter dari last value from split dan ganti ke caps
	//dengan cara ambil ASCII byte pertama di kurangi 32
	byteLastValue := []byte(lastValueFromSplit)
	if byteLastValue[0] >= 'a' && byteLastValue[0] <= 'z' {
		byteLastValue[0] = byteLastValue[0] - 32
	}

	finalResult := string(byteLastValue)
	return finalResult
}
