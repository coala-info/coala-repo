# ucsc-twobitdup CWL Generation Report

## ucsc-twobitdup_twoBitDup

### Tool Description
check to see if a twobit file has any identical sequences in it

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-twobitdup:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-twobitdup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-twobitdup/overview
- **Total Downloads**: 34.2K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
twoBitDup - check to see if a twobit file has any identical sequences in it
usage:
   twoBitDup file.2bit
options:
  -keyList=file - file to write a key list, two columns: md5sum and sequenceName
  -udcDir=/dir/to/cache - place to put cache for remote bigBed/bigWigs

example: twoBitDup -keyList=stdout db.2bit \
          | grep -v 'are identical' | sort > db.idKeys.txt
```

