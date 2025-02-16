cat << 'EOF' > /usr/local/bin/cns
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: cns <namespace>"
    exit 1
fi

kubectl config set-context --current --namespace="$1"
echo "Switched to namespace: $1"
EOF

chmod +x /usr/local/bin/cns