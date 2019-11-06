# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bureau"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git debian adb colored-man-pages command-not-found mosh extract docker zsh-navigation-tools zsh_reload
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PATH=$PATH:/opt/phantomjs/bin
alias mehdivpn="echo 'eXtrem0u5'|sudo openconnect 95.216.136.163:4433 --servercert sha256:05c448bd0dc7e0936b09be7a4c5ef5e5bc7637b196d43b6d242ad10b1f7c8a33 --background --syslog --authgroup='Route[Exclude IRAN]' --user=mehdi --passwd-on-stdin --interface vpn4"
alias opendisconnect='sudo kill -SIGINT $(pgrep openconnect)'

[ $(echo $OS|grep -i Windows) ] || defgw=$(ip r|grep default|awk '{print $3}')
[ $(echo $OS|grep -i Windows) ] || \
alias fixroute='sudo ip route add 172.16.11.0/24  via $defgw;
                sudo ip route add 172.16.2.0/24   via $defgw;
                sudo ip route add 172.16.130.0/24 via $defgw;
                sudo ip route add 172.16.131.0/24 via $defgw;
                sudo ip route add 172.16.133.0/24 via $defgw;
                sudo ip route add 172.16.137.0/24 via $defgw;
                sudo ip route add 172.16.141.0/24 via $defgw;
                sudo ip route add 172.16.190.0/24 via $defgw;
                sudo ip route add 172.16.149.0/24 via $defgw;
                sudo ip route add 172.16.119.0/24 via $defgw;
                sudo ip route add 172.30.20.0/24  via $defgw;
                sudo ip route add 172.16.23.0/24  via $defgw;
                sudo ip route add 79.175.191.18   via $defgw;
                sudo ip route add 172.16.17.0/24  via $defgw;
                sudo ip route add 93.113.225.22   via $defgw;
                sudo ip route add 172.16.20.0/24  via $defgw'


alias netreset='sudo systemctl stop network-manager networking  &&
                for vpniface  in $(ip link|egrep "^[0-9]+: vpn"|cut -d: -f2|tr -d ":"|tr -d " "); do         sudo ip link delete $vpniface;     done &&
                for interface in $(ip link|egrep "^[0-9]+: [^(lo|vpn)]"|cut -d: -f2|tr -d ":"|tr -d " "); do sudo ip addr flush dev $interface; done &&
                sudo systemctl start network-manager networking'


alias digivpn="echo 't1BMPUPR1qITl)D\'|sudo openconnect --authgroup Digikala -u a.hamidi --passwd-on-stdin --servercert sha256:3f148808b82137b20e54074b24ab61de548234caddfada85d76e372a9d5a898b 79.175.191.16"
alias mytubevid='youtube-dl --proxy socks5://127.0.0.1:1080 --write-sub --write-auto-sub --sub-lang en --sub-lang en-GB --embed-subs'
alias mytubemp3='youtube-dl --proxy socks5://127.0.0.1:1080 -x --audio-format mp3'

alias myconv="iconv -f WINDOWS-1256 -t UTF-8"

alias variety='HTTP_PROXY="http://127.0.0.1:8118" variety'
