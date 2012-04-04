# remove a circular symlink
rm $GEO_WORK/geocities/www.geocities.com/bourbonstreet/BourbonStreet

# resolve leftover symlink
rm $GEO_WORK/geocities/www.geocities.com/soho
mv $GEO_WORK/geocities/YAHOOIDS/S/o/SoHo $GEO_WORK/geocities/www.geocities.com/soho

# real    0m1.230s
# user    0m0.004s
# sys     0m0.008s
