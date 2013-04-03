# Hand-picked destruction of symlink cancer, directories
# nested in themselves, probably caused by symlinks on the
# Geocities server. It's turtles all the way down ...
# These almost endless loops mess up the file system big time,
# generating false impressions of users being overly active
# and burning processor cycles and storage memory.
# It is save to remove these directories if the data they contain
# is the same.
#
# These directories have been manually checked for being save
# to remove. To find them, the SQL query in $GEO_SCRIPTS/sql/do/find-doubles.sql
# was used, based on the doubles-dir data generated in 009-case-insensitivity-dirs.sh

rm -rv $GEO_WORK/geocities/www.geocities.com/Tokyo/Temple/2506/pisces/beth/beth

rm -rv $GEO_WORK/geocities/www.geocities.com/Wellesley/Veranda/9569/index/harvest/harvest

rm -rv $GEO_WORK/geocities/www.geocities.com/boostmom/links/links/links

rm -rv $GEO_WORK/geocities/www.geocities.com/Heartland/Shores/9064/links/links/links

rm -rv $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Performance/3412/Bilder/blog.html/radio/radio

rm -rv $GEO_WORK/geocities/www.geocities.com/Hollywood/Club/3318/horses/gallery

rm -rv $GEO_WORK/geocities/www.geocities.com/Colosseum/Pressbox/9206/nfcnorth/www.midsouth.net/spitfire/www.midsouth.net

rm -rv $GEO_WORK/geocities/www.geocities.com/EnchantedForest/Dell/2237/dino/dino/dino

rm -rv $GEO_WORK/geocities/www.geocities.com/Heartland/Hills/1217/graphics/graphics/framed/framed

rm -rv $GEO_WORK/geocities/www.geocities.com/kinomakoto14/sm/picture/picture

rm -rv $GEO_WORK/geocities/www.geocities.com/Colosseum/4137/res9899/res9899/res9899

rm -rv $GEO_WORK/geocities/www.geocities.com/Vienna/Studio/5505/PolarBear/PolarBear/PolarBear_files/PolarBear_files

rm -rv $GEO_WORK/geocities/www.geocities.com/Colosseum/Pressbox/9206/nfceast.html/dibears101.geo/dibears101.geo

rm -rv $GEO_WORK/geocities/www.geocities.com/rosella.geo/graphics/graphics/framed/framed/framed

rm -rv $GEO_WORK/geocities/www.geocities.com/WestHollywood/Chelsea/4524/juke/music.html/music.html

rm -rv $GEO_WORK/geocities/www.geocities.com/dburton_1951/PolarBear/PolarBear/PolarBear_files/PolarBear_files

rm -rv $GEO_WORK/geocities/www.geocities.com/kc2awa_grapee/Sayings.html/geobook.html/geobook.html

rm -rv $GEO_WORK/geocities/www.geocities.com/Colosseum/Pressbox/9206/nfcnorth.html/www.midsouth.net/spitfire/www.midsouth.net
rm -rv $GEO_WORK/geocities/www.geocities.com/Colosseum/Pressbox/9206/nfcnorth.html/www.midsouth.net/www.midsouth.net

rm -rv $GEO_WORK/geocities/www.geocities.com/Pipeline/4966/islam/islam

rm -rv $GEO_WORK/geocities/www.geocities.com/Yosemite/Rapids/6597/teoria.html/teoria2.html/teoria2.html

rm -rv $GEO_WORK/geocities/www.geocities.com/RainForest/Jungle/5432/links.html/http/www.sca-inc.org/http

rm -rv $GEO_WORK/geocities/www.geocities.com/Yosemite/Meadows/1967/where.html/where.html

rm -rv $GEO_WORK/geocities/www.geocities.com/Paris/Arc/4398/friend.html/cgi_bin/geoplus_apps/cgi_bin

# We've got a hard one for you!
alldirs=(logo karen gif html_tutorials treasure_trove midi gifs site_features sailormars southpark tutorials menu emiri me jpg myself);
for topdir in ${alldirs[@]}; do
    for deepdir in ${alldirs[@]}; do
        rm -rv $GEO_WORK/geocities/www.geocities.com/mitzrah_cl/$topdir/$deepdir;
    done
done

# Older version of the same page in Tokoy
alldirs=(gifs hints_n_tips jpg karen sailormars site_features tutorials www_stuff);
for topdir in ${alldirs[@]}; do
    for deepdir in ${alldirs[@]}; do
        rm -rv $GEO_WORK/geocities/www.geocities.com/Tokyo/6140/myself/$topdir/$deepdir;
    done
done


rm -rv $GEO_WORK/geocities/www.geocities.com/Hollywood/Hills/1350/dbs/dbs
rm -rv $GEO_WORK/geocities/www.geocities.com/Hollywood/Hills/1350/dbs/emblems/dbs
rm -rv $GEO_WORK/geocities/www.geocities.com/Hollywood/Hills/1350/dbs/emblems/emblems

rm -rv $GEO_WORK/geocities/www.geocities.com/Area51/Keep/8907/Klingonregistry/Klingonregistry

rm -rv $GEO_WORK/geocities/www.geocities.com/timessquare/galaxy/1821/index/www.geocities.com/www.geocities.com

rm -rv $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Underground/5244/bands/bands

alldirs=(art_cel.html bios_family.html news_main.html pinocchio_story.html prose_poem.html)
for topdir in ${alldirs[@]}; do
    for deepdir in ${alldirs[@]}; do
        rm -rv $GEO_WORK/geocities/www.geocities.com/Paris/Gallery/7842/$topdir/$deepdir;
    done
done

rm -rv $GEO_WORK/geocities/www.geocities.com/Tokyo/Teahouse/4122/geobook.html/snap.to/snap.to

rm -rv $GEO_WORK/geocities/www.geocities.com/Tokyo/Shrine/3376/Shampoo/Pictures/Pictures

# biggie
rm -rv $GEO_WORK/geocities/www.geocities.com/SoHo/Workshop/9176/Clown/Clown

# this one was 2.1 GB!
alldirs=(actors authors basarke credits gallery Julie media Newsletters smith szpindel)
for topdir in ${alldirs[@]}; do
    for deepdir in ${alldirs[@]}; do
        rm -rv $GEO_WORK/geocities/www.geocities.com/canadian_sf/pages/authors/media/$topdir/$deepdir;
    done
done

# One of these directories that is actually a HTML file ...
rm -rv $GEO_WORK/geocities/www.geocities.com/SoHo/7931/midi

# In the conflict directories there's some sickness floating
# around as well! Found by using the 'tree -dfin' command and
# watching the output rush by. :)

rm -rv $GEO_WORK/geocities_conflicts_1/www.geocities.com/Hollywood/Academy/5235/index.html/www.geocities.com

rm -rv $GEO_WORK/geocities_conflicts_1/www.geocities.com/Hollywood/Hills/7415/Trash/Trivia.html/Trivia.html

