#!/bin/sh

handle_exit() {
	[ $# -eq 1 ] || exit 1

	if [ "${1}" -eq 0 ]; then
		printf "OK.\n"
	else
		printf "FAIL.\n"
		exit 1
	fi
}

for test in *; do
	[ -e "${test}/test-ignore" -o -f "${test}" ] && continue

	name=${test##*/}

	printf "Building sw '%s': " "${name}"
	make -C "${test}" all >/dev/null
	handle_exit $?

	printf "Running sw '%s': " "${name}"
	make -C "${test}" sim >/dev/null 2>&1
	handle_exit $?
done
