# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ "$HOST" == "OFFICE-HOSTNAME" ]]; then
    ZSH_THEME="bureau"
else
    ZSH_THEME="mlh"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  command-not-found
  debian
  docker
  extract
  git
  kubectl
  mosh
  pip
  python
  sudo
  systemd
  vscode
  zsh-navigation-tools
  vagrant
  helm
  argocd
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
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


reload() {
  omz reload
}

## Downloading
alias mytubevid='yt-dlp --proxy socks5://127.0.0.1:12334 --write-sub --write-auto-sub --sub-lang en --embed-subs --cookies-from-browser firefox'
alias mytubevid-noproxy='yt-dlp -f best --write-sub --write-auto-sub --sub-lang en --embed-subs --cookies-from-browser firefox'
alias mytubemp3='yt-dlp --proxy socks5://127.0.0.1:12334 -x --audio-format mp3 --cookies-from-browser firefox'
alias mytubemp3-noproxy='yt-dlp -x --audio-format mp3 --cookies-from-browser firefox'
mytubeplay() {
  echo "$@"|egrep -q '(yt.be|youtube)' && convfmt=mpegts || convfmt=matroska
  echo "$@" '-->>' "$convfmt"
  yt-dlp --proxy socks5://127.0.0.1:12334 --cookies-from-browser firefox -o - "$@" | ffmpeg -i pipe:0 -c copy -f $convfmt - | vlc -
}
mytubeplay-noproxy() {
  echo "$@"|egrep -q '(yt.be|youtube)' && convfmt=mpegts || convfmt=matroska
  echo "$@" '-->>' "$convfmt"
  yt-dlp --cookies-from-browser firefox -o - "$@" | ffmpeg -i pipe:0 -c copy -f $convfmt - | vlc -
}

## Subtitle Conversion
alias myconv="iconv -f WINDOWS-1256 -t UTF-8"
myconvcurrentdir() {
    file *.srt|grep Non-ISO | while read -r line; do fn="$(echo $line|cut -d: -f1)"; nfn="$(echo $fn|sed 's/\.srt/\.fixed\.srt/g')"; echo CONVERTING "$fn" to "$nfn" . . .; myconv "$fn" > "$nfn" && rm "$fn"; done
}

## Force Variety from HTTP Proxy
#alias variety='HTTP_PROXY="http://127.0.0.1:8118" variety'

## Studio3T
alias studio3t-trial-reset='~/Software/Studio3TUnlimited/trial-reset.sh'
alias studio3t='xhost +SI:localuser:root && docker run -d --rm  \
                              --name mystudio3t \
                              --volume="$HOME/.3T:/root/.3T" \
                              --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
                              --volume="$Home/Desktop:/root/Desktop" \
                              --net=host \
                              --env="DISPLAY" \
                registry.myoffice.com/operation/studio3t /opt/studio3t/Studio-3T'

# VSCodium instead VSCode
alias code=codium

## enforces mcedit to be used on `kubectl edit`
export KUBE_EDITOR=mcedit

## whois proxy :)
#alias whois-proxy='proxychains4 whois'

## Upgrade Local Binary Executables
alias upgrade-yt-dlp='wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ~/.local/bin/yt-dlp && chmod a+rx ~/.local/bin/yt-dlp'
alias upgrade-helm='wget -qO - https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash'
alias upgrade-winetricks='wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O ~/.local/bin/winetricks && chmod +x ~/.local/bin/winetricks'
alias upgrade-sppedtest='pip install --user speedtest-cli --break-system-packages --upgrade --force-reinstall'
alias upgrade-argocd-cli='wget https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 -cO ~/.local/bin/argocd && chmod +x ~/.local/bin/argocd'
alias upgrade-deb-get='curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get'

function upgrade-terraform () {
    version=$(curl -sx socks5://127.0.0.1:20170 https://checkpoint-api.hashicorp.com/v1/check/terraform|jq .current_version|tr -d '"')
    curl -JLOx socks5://127.0.0.1:20170 https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip
    sudo unzip terraform_${version}_linux_amd64.zip terraform -d /usr/local/bin && sudo rm terraform_${version}_linux_amd64.zip
}

function cafebazardl () {
pkgid=$1
curl --location 'https://api.cafebazaar.ir/rest-v1/process/AppDownloadInfoRequest' \
     --data '{"properties":{"language":2,"clientVersionCode":1100301,"androidClientInfo":{"sdkVersion":23,"cpu":"x86,armeabi-v7a,armeabi"},"clientVersion":"11.3.1","isKidsEnabled":false},"singleRequest":{"appDownloadInfoRequest":{"downloadStatus":1,"packageName":"'${pkgid}'","referrers":[]}}}' \
     | jq '.singleReply.appDownloadInfoReply.fullPathUrls[]' \
     | tail -1 \
     | xargs curl -JLo ${pkgid}
}

# --- Auto rehash when new commands appear ---
# This makes Zsh automatically rehash its command hash table
# so newly installed binaries are found without needing 'rehash' or 'omz reload'
autoload -U compinit
compinit
zstyle ':completion:*' rehash true
