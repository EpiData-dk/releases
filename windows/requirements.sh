## SSL FILES:
# https://wiki.openssl.org/index.php/Binaries
# https://wiki.overbyte.eu/wiki/index.php/ICS_Download#Download_OpenSSL_Binaries
# https://indy.fulgan.com/SSL/


os_commands() {
    local cmds=(zip wget unzip wine)
    printf "%s\n" "${cmds[@]}"
}