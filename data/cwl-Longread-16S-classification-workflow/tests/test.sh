# Cleaning up old runs
CMD="rm -rf OUT PROV/"
echo "> $CMD"
$CMD

TMPDIR=$(pwd)/TMP
# --cachedir CACHE --provenance PROV
CMD="cwltool --outdir OUT --provenance PROV $@" 
echo "> $CMD"
$CMD
