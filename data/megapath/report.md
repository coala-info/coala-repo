# megapath CWL Generation Report

## megapath_runMegaPath.sh

### Tool Description
Runs the MegaPath pipeline for sequence analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath:2--h43eeafb_4
- **Homepage**: https://github.com/edwwlui/MegaPath
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/edwwlui/MegaPath
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/runMegaPath.sh -1 <read1.fq> -2 <read2.fq> [options]
    -p  output prefix [megapath]
    -t  number of threads [24]
    -c  NT alignment score cutoff [40]
    -s  SPIKE filter number of stdev [60]
    -o  SPIKE overlap [0.5]
    -L  max read length [150]
    -d  database directory [/usr/local/MegaPath/db]
    -S  Perform ribosome filtering
    -H  skip human filtering
    -A  Perform assembly & protein alignment
```


## megapath_runMegaPath-Amplicon.sh

### Tool Description
Run MegaPath for amplicon sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath:2--h43eeafb_4
- **Homepage**: https://github.com/edwwlui/MegaPath
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/runMegaPath-Amplicon.sh -1 <read1.fq> -2 <read2.fq> [options]
    -p  output prefix [megapath-amplicon]
    -t  number of threads [45]
    -L  max read length [250]
    -d  database directory [/usr/local/MegaPath/db]
```


## megapath_bwa

### Tool Description
alignment via Burrows-Wheeler transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath:2--h43eeafb_4
- **Homepage**: https://github.com/edwwlui/MegaPath
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Validation**: PASS

### Original Help Text
```text
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.12-r1039
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries

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

