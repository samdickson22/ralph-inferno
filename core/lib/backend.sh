#!/bin/bash
# backend.sh - Unified LLM backend abstraction layer
# Source this file: source lib/backend.sh
#
# Supports: claude (Claude Code CLI), opencode (OpenCode CLI)
# Config: RALPH_BACKEND env var or .ralph/config.json "backend" field

# Prevent double-sourcing
[ -z "${BACKEND_LOADED:-}" ] || return 0
BACKEND_LOADED=true

CONFIG_FILE="${RALPH_CONFIG:-.ralph/config.json}"

# Read config value
_backend_config() {
    local key="$1"
    jq -r ".$key // empty" "$CONFIG_FILE" 2>/dev/null
}

# Get backend from env or config, default to claude
get_backend() {
    local backend="${RALPH_BACKEND:-}"
    if [ -z "$backend" ]; then
        backend=$(_backend_config "backend")
    fi
    echo "${backend:-claude}"
}

# Run code generation with the configured backend
# Usage: run_backend_code "prompt" [timeout_seconds]
run_backend_code() {
    local prompt="$1"
    local timeout="${2:-300}"
    local backend=$(get_backend)

    case "$backend" in
        claude)
            echo "$prompt" | timeout "$timeout" claude --dangerously-skip-permissions -p 2>&1
            ;;
        opencode)
            timeout "$timeout" opencode run "$prompt" 2>&1
            ;;
        *)
            echo "Unknown backend: $backend" >&2
            return 1
            ;;
    esac
}

# Run vision/image analysis with the configured backend
# Usage: run_backend_vision "prompt" "image_path"
run_backend_vision() {
    local prompt="$1"
    local image_path="$2"
    local backend=$(get_backend)

    case "$backend" in
        claude)
            echo "$prompt" | claude --dangerously-skip-permissions -p --image "$image_path" 2>&1
            ;;
        opencode)
            # OpenCode vision support via MCP (not yet implemented)
            echo "Vision not supported by opencode backend" >&2
            return 1
            ;;
        *)
            echo "Unknown backend: $backend" >&2
            return 1
            ;;
    esac
}

# Check if the configured backend CLI is installed
# Usage: check_backend
check_backend() {
    local backend=$(get_backend)

    case "$backend" in
        claude)
            which claude >/dev/null 2>&1
            ;;
        opencode)
            which opencode >/dev/null 2>&1
            ;;
        *)
            echo "Unknown backend: $backend" >&2
            return 1
            ;;
    esac
}

# Get the backend CLI command name (for error messages)
get_backend_cli() {
    local backend=$(get_backend)
    case "$backend" in
        claude)   echo "claude" ;;
        opencode) echo "opencode" ;;
        *)        echo "$backend" ;;
    esac
}
