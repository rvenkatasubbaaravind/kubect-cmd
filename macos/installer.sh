echo "
parse_kube_context() {
    local context=\$(kubectl config current-context 2>/dev/null)
    local namespace=\$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)

    [[ -z \"\$namespace\" ]] && namespace=\"default\"

    # Extract only the part after \"infoblox.com\"
    local filtered_context=\$(echo \"\$context\" | sed -E 's/.*infoblox\\.com-//')

    # Define green color and reset color codes
    local GREEN=\"%{\$(tput setaf 2)%}\"
    local RESET=\"%{\$(tput sgr0)%}\"

    if [[ -n \"\$filtered_context\" ]]; then
        echo \"\${GREEN}(\${filtered_context} | \${namespace})\${RESET}\"
    fi
}
" > ~/.kube_prompt.sh

echo "
#!/bin/bash

CONFIG_FILE=\"\$HOME/.kubectl_helper_status\"

if [ \"\$1\" == \"on\" ]; then
    echo \"on\" > \"\$CONFIG_FILE\"
    echo \"Kubernetes helper enabled.\"
elif [ \"\$1\" == \"off\" ]; then
    echo \"off\" > \"\$CONFIG_FILE\"
    echo \"Kubernetes helper disabled\"
else
    echo \"Usage: kubectl-helper [on|off]\"
    exit 1
fi
# Apply the change immediately
exec zsh
" > ~/kubectl-helper

chmod +x ~/kubectl-helper

sudo mv ~/kubectl-helper /usr/local/bin/

# 1. Make the script executable
chmod +x ~/.kube_prompt.sh

# 2. Add the kube prompt to the .zshrc file
echo "
source ~/.kube_prompt.sh 
if [[ -f \"\$HOME/.kubectl_helper_status\" && \"\$(cat \$HOME/.kubectl_helper_status)\" == \"on\" ]]; then
    setopt PROMPT_SUBST
    export PS1='%n@%m \$(parse_kube_context) %~ %# '
else
    export PS1='%n@%m %~ %# ' 
fi
" >> ~/.zshrc

# 3. Source the updated .zshrc to apply changes
source ~/.zshrc

# 4. Create a script to change the Kubernetes namespace
echo "
#!/bin/bash

if [ -z \"\$1\" ]; then
    echo \"Usage: cns <namespace>\"
    exit 1
fi

kubectl config set-context --current --namespace=\"\$1\"
echo \"Switched to namespace: \$1\"
" > ~/cns

# 5. Make the namespace switch script executable
chmod +x ~/cns

# 6. Move the script to /usr/local/bin for global access
sudo mv ~/cns /usr/local/bin/cns

# 7. Inform the user to restart the terminal
echo \"Kube prompt has been added to your bash shell. Please restart your terminal to see the changes.\"