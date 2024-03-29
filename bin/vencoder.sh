#!/usr/bin/env bash

declare RETVAL
declare -a ERRBAG=()

declare -A KEEPER=(
  [tool]="$(basename "${BASH_SOURCE[0]}")"
  [bindir]="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
)
KEEPER[tooldir]="$(realpath "${KEEPER[bindir]}/..")"
KEEPER[vendordir]="${KEEPER[tooldir]}/vendor"
KEEPER[incdir]="${KEEPER[tooldir]}/inc"

. "${KEEPER[vendordir]}/.lib/lib/lib/txt.sh"
. "${KEEPER[incdir]}/init.sh"

KEEPER+=(
  [commondir]="${KEEPER[incdir]}/common"
  [presdir]="${KEEPER[tooldir]}/presets"
)
KEEPER[presets]="$(
  find "${KEEPER[presdir]}" -type f -name '*.conf' ! -name '_*' \
  | rev | cut -d'/' -f1 | rev | sed 's/\.conf$//' | sort -n
)"

. "${KEEPER[incdir]}/opts.sh"
. "${KEEPER[incdir]}/run.sh"
