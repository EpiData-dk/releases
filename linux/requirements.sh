os_commands() {
    local cmds=(tar jinja2 fakeroot dpkg-deb)
    printf "%s\n" "${cmds[@]}"
}