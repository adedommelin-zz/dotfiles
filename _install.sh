#!/bin/bash

for f in $(ls -1 ~/.dotfiles/ | grep -Ev '^[_|README\.md]');
do
  rm -f ~/.${f}
  /bin/ln -s ~/.dotfiles/${f} ~/.${f}
done
