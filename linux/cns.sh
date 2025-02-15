echo "
if [ -z \"\$1\" ]; then
    echo \"Usage: cns <namespace>\"
    exit 1
fi

kubectl config set-context --current --namespace=\"\$1\"
echo \"Switched to namespace: \$1\"
" > ./cns

# 5. Make the namespace switch script executable
chmod +x ./cns

# 6. Move the script to /usr/local/bin for global access
mv ./cns /usr/local/bin/cns