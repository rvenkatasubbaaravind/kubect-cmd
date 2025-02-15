echo "
parse_kube_context() {
    local context=$(kubectl config current-context 2>/dev/null)
    local namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)

    [[ -z "$namespace" ]] && namespace="default"

    # Extract only the part after "infoblox.com"
    local filtered_context=$(echo "$context" | sed -E 's/.*infoblox\.com-//')

    # Define green color and reset color codes
    local GREEN=\"\[\e[32m\]\"
    local RESET=\"\[\e[0m\]\"

    if [[ -n "$filtered_context" ]]; then
        echo \"${GREEN}(${filtered_context} | ${namespace})${RESET}\"
    fi
}

# For Bash
export PS1='\u@\h \$(parse_kube_context) \w \$ '

" > ~/.kube_prompt.sh

# 1. Make the script executable
chmod +x ~/.kube_prompt.sh

# 2. Update .bashrc to source the kube prompt script and set the prompt
echo "
source ~/.kube_prompt.sh 
" >> ~/.bashrc

# 3. Source the updated .bashrc to apply changes
source ~/.bashrc

# 4. Create a script to change the Kubernetes namespace
echo "
#!/bin/bash

if [ -z \"$1\" ]; then
    echo \"Usage: cns <namespace>\"
    exit 1
fi

kubectl config set-context --current --namespace=\"$1\"
echo \"Switched to namespace: $1\"
" > ~/cns

# 5. Make the namespace switch script executable
chmod +x ~/cns

# 6. Move the script to /usr/local/bin for global access
sudo mv ~/cns /usr/local/bin/cns

# 7. Inform the user to restart the terminal
echo "Kube prompt has been added to your bash shell. Please restart your terminal to see the changes."