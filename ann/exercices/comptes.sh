#!/usr/bin/bash
echo "Nombre de 'locations' par année:"
echo "2016: $(grep 'Location' 2016/*.ann | wc -l)"
echo "2017: $(grep 'Location' 2017/*.ann | wc -l)"
echo "2018: $(grep 'Location' 2018/*.ann | wc -l)"