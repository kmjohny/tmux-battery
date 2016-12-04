#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
full_icon="";
empty_icon="";

full_icon_default="◼";
empty_icon_default="◻";

# icons are set as script global variables
get_icon_settings() {
	full_icon=$(get_tmux_option "@batt_full_icon" "$full_icon_default")
  empty_icon=$(get_tmux_option "@batt_empty_icon" "$empty_icon_default")
}

print_graph() {
  output=''
  for ((i=0; i<${#color_palette[*]}; i++));
  do
    if [ "$i" -le "$(($1/10))" ]
    then
      output+="$(get_color $i)"$full_icon
    else
      output+="$(get_color $i)"$empty_icon
    fi
  done
  printf ${output}#[fg=colour0]
}

main() {
	get_icon_settings
  local percentage=$($CURRENT_DIR/battery_percentage.sh)
	print_graph ${percentage%?}
}
main
