#!/bin/bash

# Geocities users used a variety of encoding schemes
# for their file names and URLs. If not ASCII, they need
# to be harmonized to utf8 in order to make all
# URLs resolvable and the database consistent.
# After identifying all problematic file names with a dry run
# of convmv
#
#    (convmv --lowmem -r --nfc -f latin1 -t utf8 *) 2>&1 >> $GEO_LOGS/encoding_errors.txt
#
# each file was examined manually. Depending on the encoding
# information, links end embeds in the surrounding HTML
# files, the encoding of the file name was determined.
# This, people, shows why utf8 was such a great invention!
#
# The most common encoding is iso-8859-1, containg Western
# European characters.
#
# As some character encoding issues are the result of using
# parametrized URLs with question marks, some of the fixes
# here overlap with what the next script is trying to achieve.

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Museum/1134
&& convmv -f Windows-1251 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/zteffen/Clints_hjemmeside/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/bill_dietrich/
&& mv MapBoatPosition.html\?24\,48.220\,N\,81\,28.620\,W\,24.48.220\ 81.28.620 MapBoatPosition.html
&& rm MapBoatPosition.html\?* ;

cd Magnolia
&& mv Picture.html\?Pics%2FWomenTowed-WhiteBay-2007-06-14.JPG\,Women\ towed Picture.html
&& rm Picture.html\?* ;

cd $GEO_WORK/geocities/www.geocities.com/CapitolHill/4068/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapitolHill/7444/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapitolHill/3697/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapitolHill/Embassy/2572/images/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Park/8073/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Haven/7248/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Haven/9474/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Fair/8554/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Farm/6197/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Petsburgh/Zoo/1924/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/pipeline/slope/5758/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/capecanaveral/1588/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Agency/4504/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Mansion/1781/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Screen/1637/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Cinema/6059/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Boulevard/5755/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Hollywood/Location/6082/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/HotSprings/Bath/3489/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/HotSprings/1028/ADCK/ 
&& convmv -f euckr -t utf8 --notest *
&& rm ybs.htm\?유병수 ;

cd $GEO_WORK/geocities/www.geocities.com/HotSprings/Spa/2545/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/dasbinich_w/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Inlet/9128/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Channel/2689/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Surf/4274/ 
&& rm directory.htm\?* ;
&& rm hall80-3.htm\?* ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Shores/7352/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Cove/1692/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Tidepool/7107/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Terrace/2744/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Keys/3503/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Bungalow/9919/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SouthBeach/Island/3922/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pentagon/Bunker/3931/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pentagon/Base/9367/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/knm_kunna/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/timessquare/cauldron/1724/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/tokyo/spa/4302/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/tokyo/market/3268/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/dmguideculture/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/PicketFence/Street/6192/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Speedway/5772/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Factory/8015/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Shop/2610/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Shop/7031/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Lane/9830/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Lane/4797/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Pit/6363/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/patricialourenco/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Drive/4119/ 
&& convmv -f iso-8859-9 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Grid/8475/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Grid/7956/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Monitor/9742/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Bit/6700/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Mouse/4535/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Lakes/7153/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Port/4421/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Port/6759/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SiliconValley/Port/9393/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Olympus/8778/Fag/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Stage/6170/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Thebes/2292/Deutsch/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest *
&& rm DieterComicDe.htm\?_Hier_klicken_für_ein_neues_Finster ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Thebes/4446/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Sparta/8103/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Sparta/5102/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Rhodes/4475/ 
&& convmv -f iso-8859-7 -t utf8 -r  --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Rhodes/4215/hector/hdc2/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Agora/7130/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Atlantis/4724/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Atlantis/2027/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Athens/Pantheon/3704/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/radarnew/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MadisonAvenue/Suite/3155/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Festival/1941/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * 
&& rm ccp.html\?¿\?¿\?¿\?¿  ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Gala/7580/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Disco/9839/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Theater/7242/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/4794/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Street/4548/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Loge/8730/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Performance/2706/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SunsetStrip/Vine/9144/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/matfor_2000/Videoke/nacionais_a_f/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/redirect/
&& mv index.html\?a001.html index.html ;
&& rm index.html\?* ;

cd $GEO_WORK/geocities/www.geocities.com/Heartland/Lake/1615/foto/Darup/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;


cd $GEO_WORK/geocities/www.geocities.com/Heartland/Cottage/3802/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * 
&& rm geobook.html\?¿\?confused\?¿\?  ;

cd $GEO_WORK/geocities/www.geocities.com/lucioleo/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/mandy_tv_at/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/NapaValley/Vineyard/7635/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/WestHollywood/9346/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/WestHollywood/Club/8515/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/WestHollywood/Chelsea/4652/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/manu_svezia/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Baja/Cliffs/8156/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/Cockpit/7618/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/Cockpit/7333/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/Cockpit/5902/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/Station/3198/ 
&& convmv -f cp1253 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/1588/Vorklinik/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/1588/Skiorte/Galtuer/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CapeCanaveral/Galaxy/2330/ 
&& convmv -f cp1250 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Wellesley/Commons/5886/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Nook/5027/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Veranda/6717/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Exhibit/4200/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Lofts/2988/
&& convmv -f big5-eten -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Hall/6953/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Suite/1300/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Suite/3989/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Study/3648/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/Study/9535/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/SoHo/exhibit/4200/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/4233/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Beach/3237/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Cove/8957/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Resort/9862/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/4375/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Equator/8705/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Coast/4296/
&& mv MapBoatPosition.html\?24\,48.220\,N\,81\,28.620\,W\,24.48.220\ 81.28.620 MapBoatPosition.html
&& rm MapBoatPosition.html\?* ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Lagoon/6081/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TheTropics/Paradise/4058/
&& rm chinanews.htm\?* ;

cd $GEO_WORK/geocities/www.geocities.com/thetropics/harbor/8923/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Tokyo/Harbor/9261/Download/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Tokyo/Market/3268/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Tokyo/Flats/4970/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Tokyo/Teahouse/6889/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Tokyo/Teahouse/1924/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Stargate/5725/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Keep/9212/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Keep/5049/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Aurora/9449/imagens/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Aurora/8832/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Comet/9651/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/7190/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Zone/9607/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Area51/Atlantis/5964/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TelevisionCity/Taping/7606/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TelevisionCity/4619/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TelevisionCity/Set/8761/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/BourbonStreet/6195/h/Hombres_G/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/h_jaehring/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/FashionAvenue/Salon/5337/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Nashville/Opry/9685/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pipeline/Cliff/9563/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pipeline/Slope/5758/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pipeline/Slope/4805/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pipeline/Slope/7541/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Pipeline/Rapids/3193/eva/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Parc/2423/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Parc/8279/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Salon/5379/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Villa/6730/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Opera/3219/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Maison/7700/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Maison/3864/ 
&& convmv -f cp874 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/LeftBank/4494/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/Chateau/6686/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/ResearchTriangle/System/1704/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/ResearchTriangle/Campus/6418/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/ResearchTriangle/Station/3052/Fundos_de_tela/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/ResearchTriangle/Forum/5579/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/RainForest/Canopy/9719/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/RainForest/Andes/7144/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/RainForest/1076/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/flokatis/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Yosemite/Campground/2775/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/motorcity/lane/9830/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;


cd $GEO_WORK/geocities/www.geocities.com/Augusta/Green/9785/pueblos/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Augusta/Links/1903/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/mark1971a20/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Grounds/8751/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Grounds/7171/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Center/7637/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Center/5340/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Theater/5370/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Pool/9390/index_dosyalar/pokemon_dosyalar/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/CollegePark/Pool/1524/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/webriotz/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest *
&& rm ccp.html\?¿\?¿\?¿\?¿  ;

cd $GEO_WORK/geocities/www.geocities.com/innamorati_di_maria/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Track/3542/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Stands/8183/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Field/8737/Breve/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Hoop/9447/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Hoop/1781/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/1906/info/bmst99/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Dome/2245/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Slope/5497/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Base/7565/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Colosseum/Lodge/4638/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/bourbonstreet/6195/h/Hombres_G/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/vienna/strasse/8444/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Vienna/Strasse/4572/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Vienna/Strasse/8444/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Vienna/Studio/8739/ 
&& convmv -f euckr -t utf8 --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Cave/7752/ 
&& convmv -f cp1254 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Cave/7105/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Ring/1107/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest *
&& rm geobook.html\?njiösch\? ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Corridor/8831/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Corridor/1041/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Bridge/2232/ 
&& convmv -f cp1252 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Metro/9162/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Dome/5724/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/TimesSquare/Bunker/3882/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Eureka/Vault/3407/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Eureka/Mine/2901/ 
&& convmv -f KOI8-R -t utf8 -r --notest  * ;

cd $GEO_WORK/geocities/www.geocities.com/Eureka/Gold/5308/ 
&& convmv -f cp1253 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Eureka/Company/8808/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/MotorCity/Lane/8195/ 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;

cd $GEO_WORK/geocities/www.geocities.com/Paris/LeftBank/4494 
&& convmv -f iso-8859-1 -t utf8 -r --notest * ;