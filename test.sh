#!/bin/sh

current_branch=$(git branch | grep \* | cut -d ' ' -f2)

arg=${@:-$(git branch | grep \* | cut -d ' ' -f2)}

echo $current_branch

echo $arg
