#
# .zshrc
#
# @author Matthijs Logemann
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Lots of additional paths, might need to clean this up sometime
export PATH="/usr/local/share/zsh/site-functions:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/matthijs/.local/bin"
export PATH="$PATH:$HOME/.composer/vendor/bin:/Users/matthijs/Library/Python/3/bin:/Users/matthijs/Development/flutter/bin:/usr/local/MacGPG2/bin/"

# Set the zsh theme to agnoster
ZSH_THEME="agnoster"

# Change default user to matthijs
DEFAULT_USER="matthijs"

# Ignore supposed permission issues when using root user
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Enable plugins
plugins=(git ssh-agent docker docker-compose brew history history-substring-search xcode)

#zstyle :omz:plugins:ssh-agent identities id_rsa id_logicbit id_logicbit_root id_rpi id_xs4all

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/matthijs/.local/bin:$HOME/.composer/vendor/bin:/Users/matthijs/Library/Python/3/bin:/Users/matthijs/Development/flutter/bin:/usr/local/MacGPG2/bin/"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys.
source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

alias svr="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias python='python3'
alias pip='pip3'

# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Setup YubiKey SSH authentication
export "GPG_TTY=$(tty)"
export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
gpgconf --launch gpg-agent

# Reset hardware key, as it sometimes gets captured by gpg
resetcard() {
  rm -r ~/.gnupg/private-keys-v1.d
  gpgconf --kill gpg-agent
  gpg --card-status
}

# Delete a given line number in the known_hosts file.
knownrm() {
 re='^[0-9]+$'
 if ! [[ $1 =~ $re ]] ; then
   echo "error: line number missing" >&2;
 else
   sed -i '' "$1d" ~/.ssh/known_hosts
 fi