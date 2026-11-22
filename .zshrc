# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim

# Completion (dump kept in cache to not pollute home directory)
[[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump

# Zsh autosuggestion
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# p10k theme and config
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# SSH
alias s="ssh"

# Added for NVM
 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Security labs

KALI_VMX="$HOME/VirtualMachine/Kali Linux.vmwarevm/Kali Linux.vmx"

lab() {
  vmrun start "$KALI_VMX" nogui
  ssh -D 1080 kali@"$(vmrun getGuestIPAddress "$KALI_VMX" -wait)"
}

alias labstop='vmrun suspend "$KALI_VMX"'
alias htb-ff='open -na "Zen" --args -P HTB'
