#!/bin/bash
dir=$(dirname $0)
for f in $dir/functions/*; do
	source $f;
done;

for f in $dir/aliases/*; do
	source $f;
done;
