# ucsc-mafsplit CWL Generation Report

## ucsc-mafsplit_mafSplit

### Tool Description
Split multiple alignment files

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-mafsplit:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-mafsplit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-mafsplit/overview
- **Total Downloads**: 24.6K
- **Last updated**: 2025-06-30
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
mafSplit - Split multiple alignment files
usage:
   mafSplit splits.bed outRoot file(s).maf
options:
   -byTarget       Make one file per target sequence.  (splits.bed input
                   is ignored).
   -outDirDepth=N  For use only with -byTarget.
                   Create N levels of output directory under current dir.
                   This helps prevent NFS problems with a large number of
                   file in a directory.  Using -outDirDepth=3 would
                   produce ./1/2/3/outRoot123.maf.
   -useSequenceName  For use only with -byTarget.
                     Instead of auto-incrementing an integer to determine
                     output filename, expect each target sequence name to
                     end with a unique number and use that number as the
                     integer to tack onto outRoot.
   -useFullSequenceName  For use only with -byTarget.
                     Instead of auto-incrementing an integer to determine
                     output filename, use the target sequence name
                     to tack onto outRoot.
   -useHashedName=N  For use only with -byTarget.
                     Instead of auto-incrementing an integer or requiring
                     a unique number in the sequence name, use a hash
                     function on the sequence name to compute an N-bit
                     number.  This limits the max #filenames to 2^N and
                     ensures that even if different subsets of sequences
                     appear in different pairwise mafs, the split file
                     names will be consistent (due to hash function).
                     This option is useful when a "scaffold-based"
                     assembly has more than one sequence name pattern,
                     e.g. both chroms and scaffolds.
```

