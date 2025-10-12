#!/usr/bin/bash
echo "Nombre de '$1' par année :"
echo "2016: $(grep $1 ../2016/*.ann | wc -l)"
echo "2017: $(grep $1 ../2017/*.ann | wc -l)"
echo "2018: $(grep $1 ../2018/*.ann | wc -l)"