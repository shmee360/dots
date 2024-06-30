#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.dotnet/tools
export EDITOR="nvim"
export BROWSER="firefox"
mkdir -p /tmp/mpvSockets

# enable GPG signing
#  export GPG_TTY=$(tty)
export GNUPGHOME=$HOME/.config/gnupg

if [ ! -f ~/.config/gnupg/S.gpg-agent ]; then
    eval $( gpg-agent --daemon --options ~/.config/gnupg/gpg.conf )
fi
