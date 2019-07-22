ip() {
        if [[ $@ == "route" ]]; then
                command netstat -nr
        elif [[ $@ == "a" ]]; then
                command ifconfig | grep inet
        else
                command ifconfig "$@"
        fi
}
