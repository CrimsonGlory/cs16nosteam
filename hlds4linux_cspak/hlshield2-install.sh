#!/bin/sh

cat <<EOF

--------------------------------------------------
Check HLShield forum for more informations
http://hobby.sarichioi.com/
--------------------------------------------------
EOF



if [ ! -f "hlds_run" ]; then
    echo
    echo "ERROR!!! You must be in the same folder where hlds_run is."
    exit
fi


echo -n "Checking version... "
if ! wget -o /tmp/hlshield.log http://hobby.sarichioi.com/cstrike/hlshield2-version.txt \
    -O /tmp/hlshield2-version.txt; then
  echo "failed" 
  tail -n 3 /tmp/hlshield.log | head -n 1
  rm /tmp/hlshield.log
  exit 1
fi

avail_ver=$( head -n 1 /tmp/hlshield2-version.txt )

inst_ver="none"

if [ -f hlshield2-version.txt ]; then
    inst_ver=$( head -n 1 hlshield2-version.txt )
fi

echo
echo "  >> available: ${avail_ver}"
echo "  >> installed: ${inst_ver}"

if [ "${avail_ver}" = "${inst_ver}" ]; then
    echo "Your HLShield is already updated."
    exit 0
fi

echo -n "Fetching latest HLShield... "
if ! wget -o /tmp/hlshield.log http://hobby.sarichioi.com/cstrike/hlshield-${avail_ver}.tar.gz; then
    echo "failed"
    tail -n 3 /tmp/hlshield.log | head -n 1
    rm /tmp/hlshield.log
    exit 1
fi
echo "done"

echo -n "Unpacking... "
if ! tar zxf hlshield-${avail_ver}.tar.gz; then
    echo "failed"
    exit 1
fi

need_patching=
grep hlshield.so hlds_run >/dev/null || need_patching=1
if [ "$need_patching" = "1" ]; then
    sed=`which sed 2>/dev/null`
    if [ -z ${sed} ]; then
        echo
        echo "Sorry, a can't found the 'sed' utility program in your system".
        echo "You can manually modify the hlds_run file, inserting following"
        echo "line (before 'export LD_LIBRARY_PATH'):"
        echo
        echo "export LD_PRELOAD=./hlshield.so"
        echo
    else
	${sed} -i '13i\export LD_PRELOAD=./hlshield.so \
\
export HLSHIELD_REPLY="Get lost, looser!" \
export HLSHIELD_ARCH=intel \
export HLSHIELD_PARANOID=0 \
export HLSHIELD_LOG=1 \
\
' hlds_run
    fi
fi

echo "done"

echo -n "Cleaning up... "
rm -f hlshield-${avail_ver}.tar.gz hlshield2-version.txt
mv /tmp/hlshield2-version.txt .
echo "done"
