rm ~/.kube_prompt.sh
sudo rm /usr/local/bin/kubectl-helper
# 6. Remove the namespace switch script
sudo rm /usr/local/bin/cns
# 9. Remove the kube prompt status file
rm ~/.kubectl_helper_status
# 10. Remove the kube prompt from the .zshrc file
sed -i '' '/source ~\/.kube_prompt.sh/d' ~/.zshrc
sed -i '' '/if \[\[ -f \"\$HOME\/.kubectl_helper_status\" \&\& \"\$(cat \$HOME\/.kubectl_helper_status)\" == \"on\" \]\]; then/,+3d' ~/.zshrc
# 11. Source the updavited .zshrc to apply changes
source ~/.zshrc
