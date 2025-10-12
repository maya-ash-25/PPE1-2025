#!/usr/bin/bash
echo "Classement des lieux:"
grep "Location" ../$1/$2*.ann | cut -d ' ' -f5- | sort | uniq -c | sort -nr | head -n $3