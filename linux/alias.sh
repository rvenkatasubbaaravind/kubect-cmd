echo "
k='kubectl'

g='get'
e='edit'
d='describe'
a='apply'
del='delete'
ex='exec'
lo='logs'

p='pod'
po='port-forward'
dep='deployment'
svc='service'
ns='namespace'


# Get all pods in the current namespace
alias kgp='\$k \$g \$p'
# Get all deployments in the current namespace
alias kgdep='\$k \$g \$dep'
# Get all services in the current namespace
alias kgsvc='\$k \$g \$svc'
# Get all namespaces
alias kgns='\$k \$g \$ns'

# Edit the pod with the given name
alias kep='\$k \$e \$p'
# Edit the deployment with the given name
alias kedep='\$k \$e \$dep'
# Edit the service with the given name
alias kesvc='\$k \$e \$svc'

# Describe the pod with the given name
alias kdp='\$k \$d \$p'
# Describe the deployment with the given name
alias kddep='\$k \$d \$dep'
# Describe the service with the given name
alias kdsvc='\$k \$d \$svc'

# Delete the pod with the given name
alias kdelp='\$k \$del \$p'
# Delete the deployment with the given name
alias kdeldep='\$k \$del \$dep'
# Delete the service with the given name
alias kdelsvc='\$k \$del \$svc'


" >> ~/.kubectl_aliases

# Source the .kubectl_aliases file in .zshrc if not already sourced
if ! grep -q "source ~/.kubectl_aliases" ~/.zshrc; then
    echo "
source ~/.kubectl_aliases
" >> ~/.zshrc
fi

# Source the .kubectl_aliases file to apply changes immediately
source ~/.kubectl_aliases