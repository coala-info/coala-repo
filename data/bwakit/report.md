# bwakit CWL Generation Report

## bwakit_bwa

### Tool Description
alignment via Burrows-Wheeler transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/bwakit:0.7.18.dev1--hdfd78af_0
- **Homepage**: https://github.com/lh3/bwa/tree/master/bwakit
- **Package**: https://anaconda.org/channels/bioconda/packages/bwakit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwakit/overview
- **Total Downloads**: 33.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/bwa
- **Stars**: N/A
### Original Help Text
```text
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.18-r1243-dirty
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

