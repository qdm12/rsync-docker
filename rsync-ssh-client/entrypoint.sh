#!/bin/sh

printf "\n =========================================\n"
printf " =========================================\n"
printf " =========== Rsync + SSH Client ==========\n"
printf " =========================================\n"
printf " =========================================\n"
printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"

exec rsync "$@"

status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"