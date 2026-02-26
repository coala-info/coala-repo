# ciri-full CWL Generation Report

## ciri-full_bwa

### Tool Description
alignment via Burrows-Wheeler transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
- **Homepage**: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html
- **Package**: https://anaconda.org/channels/bioconda/packages/ciri-full/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ciri-full/overview
- **Total Downloads**: 979
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/bioinfo-biols/CIRI-full
- **Stars**: N/A
### Original Help Text
```text
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.19-r1273
Contact: Heng Li <hli@ds.dfci.harvard.edu>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries (DEPRECATED)

         shm           manage indices in shared memory
         fa2pac        convert FASTA to PAC format
         pac2bwt       generate BWT from PAC
         pac2bwtgen    alternative algorithm for generating BWT
         bwtupdate     update .bwt to the new format
         bwt2sa        generate SA from BWT and Occ

Note: To use BWA, you need to first index the genome with `bwa index'.
      There are three alignment algorithms in BWA: `mem', `bwasw', and
      `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
      first. Please `man ./bwa.1' for the manual.
```

