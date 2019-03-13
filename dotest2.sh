for  variable in "sst" "t2m" "precip" ; do
   for domain in "USA" "Global65" "Global90" "Nino3.4"; do

       if [ "$variable" == "sst" ] && [ "$domain" == "USA" ] ; then
          continue
       fi

       if [ "$variable" == "sst" ] && [ "$domain" == "Global90" ] ; then
          continue
       fi

       if [ "$variable" == "precip" ] && [ "$domain" != "USA" ] ; then
          continue
       fi

       if [ "$variable" == "t2m" ] && [ "$domain" == "Global65" ] ; then
          continue
       fi

       if [ "$variable" == "t2m" ] && [ "$domain" == "Nino3.4" ] ; then
          continue
       fi

       for quantity in "cor" "rms"  ; do

          echo "$variable $domain $quantity"
       done
    done
done
           

