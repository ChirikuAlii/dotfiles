package main

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"
)

const (
	IntervalInMinutes = 5        // Run Every X minutes
	ConfigDir         = ".tmuxp" // Default folder tmuxp
)

func main() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal("Failed get home dir home directory:", err)
	}

	fullConfigPath := filepath.Join(homeDir, ConfigDir)
	ticker := time.NewTicker(IntervalInMinutes * time.Minute)

	fmt.Printf("Tmuxp Auto-Freeze active. Interval: %d minute\n", IntervalInMinutes)
	fmt.Printf("Folder Config: %s\n", fullConfigPath)

	runSync(fullConfigPath)

	for range ticker.C {
		runSync(fullConfigPath)
	}
}

func runSync(configPath string) {

	activeSessions, err := getActiveSessions()
	if err != nil {
		log.Printf(" Error take active session: %v\n", err)
		return
	}

	for _, session := range activeSessions {
		yamlFile := filepath.Join(configPath, session+".yaml")
		ymlFile := filepath.Join(configPath, session+".yml")

		if fileExists(yamlFile) || fileExists(ymlFile) {
			log.Printf("Session '%s' found. freezing...\n", session)
			freeze(session)
		} else {
			log.Printf("Session '%s' skip (not found yaml file).\n", session)
		}
	}
}

func getActiveSessions() ([]string, error) {
	cmd := exec.Command("tmux", "list-sessions", "-F", "#S")
	out, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	lines := strings.Split(strings.TrimSpace(string(out)), "\n")
	var sessions []string
	for _, line := range lines {
		if line != "" {
			sessions = append(sessions, line)
		}
	}
	return sessions, nil
}

func freeze(sessionName string) {
	cmd := exec.Command("tmuxp", "freeze", sessionName, "--force", "-y")
	cmd.Stdin = bytes.NewBufferString("\n")
	err := cmd.Run()
	if err != nil {
		log.Printf("Gagal freeze session %s: %v\n", sessionName, err)
	}
}

func fileExists(filename string) bool {
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	}
	return !info.IsDir()
}
