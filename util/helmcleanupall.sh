helm list | awk '$1!="NAME" { print $1 }' | xargs helm delete