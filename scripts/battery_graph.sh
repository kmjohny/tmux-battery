#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

full='◼';
empty='◻';

count=10;

charge=$1;

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

color=($RED $RED $RED $YELLOW $YELLOW $YELLOW $YELLOW $GREEN $GREEN $GREEN)

print_graph() {
  for ((i=0; i < $count; i++))
  do
    if [ "$i" -le "$(($1/10))" ]
    then
      printf ${color[$i]}$full${NC}
    else
      printf ${color[$i]}$empty${NC}
    fi
done
}

main() {
	local percentage=$($CURRENT_DIR/battery_percentage.sh)
	print_graph ${percentage%?}
}
main
