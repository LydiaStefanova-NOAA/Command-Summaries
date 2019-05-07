#!/bin/bash -l

# What I want to achieve: assign color according to month

pass=0

#for tag in 20120101 20120201 20120601 ; do
#    yyyy=${tag:0:4}
#    mm=${tag:4:2}
#    dd=${tag:6:2}
#done

for yyyy in {2012..2018..111} ; do
    for mm in {1..12..1} ; do
        for dd in {1..15..14} ; do

            if [ $mm -gt 11 ] ;  then                     # Winter
               color="blue"
               else if [ $mm -gt 8 ] ; then               # Autumn
                    color="orange"
                    else if [ $mm -gt 5 ] ; then          # Summer
                         color="red"
                         else if [ $mm -gt 2 ] ; then     # Spring
                              color="green"
                              else                        # Winter
                                  color="blue"
                         fi
                    fi
               fi
            fi

            if [ $pass -eq 0 ] ; then
               colors=" \" $color \" "
               pass=1
               else
                   colors=" $colors , \" $color \" "
            fi

        done
    done
done

#echo $colors
