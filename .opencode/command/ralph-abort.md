---
description: Stop Ralph on VM
agent: ralph-build
---

# /ralph-abort - Stop Ralph on VM

Stoppa Ralph gracefully pa VM.

## Usage
```
/ralph-abort
/ralph-abort --force     # Kill utan att vanta
```

## Instructions

**STEG 1: LAS VM CONFIG**
```bash
source ~/.ralph-vm
```

**STEG 2: STOPPA RALPH**
```bash
ssh $VM_USER@$VM_IP << 'EOF'
echo "=== STOPPING RALPH ==="

# Hitta Ralph-processer
PIDS=$(pgrep -f "ralph.sh|orchestrator.sh|claude" | tr '\n' ' ')

if [ -z "$PIDS" ]; then
    echo "Ralph is not running"
    exit 0
fi

echo "Found PIDs: $PIDS"

# Graceful stop forst (SIGTERM)
echo "Sending SIGTERM..."
kill $PIDS 2>/dev/null || true

# Vanta max 10 sekunder
for i in {1..10}; do
    sleep 1
    if ! pgrep -f "ralph.sh" > /dev/null; then
        echo "Ralph stopped gracefully"
        exit 0
    fi
    echo "Waiting... ($i/10)"
done

# Force kill om fortfarande igang
echo "Force killing..."
kill -9 $PIDS 2>/dev/null || true

echo "Ralph stopped (forced)"
EOF
```

**STEG 3: VISA STATUS**
```bash
# Visa vad som sparades
ssh $VM_USER@$VM_IP << 'EOF'
cd ~/projects/$(ls -t ~/projects | head -1)

echo ""
echo "=== SAVED PROGRESS ==="

if [ -d ".spec-checksums" ]; then
    done=$(ls -1 .spec-checksums/*.md5 2>/dev/null | wc -l | tr -d ' ')
    echo "Completed specs: $done"
fi

# Visa sista commit
echo ""
echo "Last commit:"
git log -1 --oneline
EOF
```

**OUTPUT:**
```
=== STOPPING RALPH ===
Found PIDs: 12345 12346
Sending SIGTERM...
Ralph stopped gracefully

=== SAVED PROGRESS ===
Completed specs: 15
Last commit: abc123 Ralph: 15-user-profile
```

**OM --force FLAGGA:**
Skippa graceful, kor direkt:
```bash
ssh $VM_USER@$VM_IP "pkill -9 -f 'ralph.sh|orchestrator.sh|claude'"
```
