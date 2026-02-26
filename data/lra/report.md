# lra CWL Generation Report

## lra_index

### Tool Description
Index global reference

### Metadata
- **Docker Image**: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
- **Homepage**: https://github.com/ChaissonLab/LRA
- **Package**: https://anaconda.org/channels/bioconda/packages/lra/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lra/overview
- **Total Downloads**: 31.7K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/ChaissonLab/LRA
- **Stars**: N/A
### Original Help Text
```text
Usage: lra global file.fa [options]
Options: 
   -CCS (flag) Index for aligning CCS reads
   -CLR (flag) Index for aligning CLR reads
   -ONT (flag) Index for aligning Nanopore reads
   -CONTIG (flag) Index for aligning large contigs
   -W (int) Minimizer window size (10).
   -F (int) Maximum minimizer frequency. (default: 250 for CLR and ONT reads; 150 for CCS reads, 30 for CONTIG.)
   -K (int) Word size
   -h Print help.
Examples: 
Index global reference for aligning CCS reads: lra global -CCS ref.fa
Index global reference for aligning CLR reads: lra global -CLR ref.fa
Index global reference for aligning Nanopore reads: lra global -ONT ref.fa
Index global reference for aligning contig: lra global -CONTIG ref.fa
```


## lra_align

### Tool Description
Align reads to a genome. The genome should be indexed using the 'lra index' program. 'reads' may be either fasta, sam, or bam, and multiple input files may be given.

### Metadata
- **Docker Image**: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
- **Homepage**: https://github.com/ChaissonLab/LRA
- **Package**: https://anaconda.org/channels/bioconda/packages/lra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lra align [options] genome.fa reads [reads2 ...]

   The genome should be indexed using the 'lra index' program.
   'reads' may be either fasta, sam, or bam, and multiple input files may be given.

Options:
   -CCS (flag)    Align CCS reads. 
   -CLR (flag)    Align CLR reads. 
   -ONT (flag)    Align Nanopore reads. 
   -CONTIG (flag) Align large contigs.
   -p  [FMT]      Print alignment format FMT='b' bed, 's' sam, 'p' PAF, 'pc' PAF with cigar, 'a' pairwise alignment.
   -H             Use hard-clipping for SAM output format.
   -Flag  F(int)  Skip reads with any flags in F set (bam input only).
   -t  n(int)     Use n threads (1).
   -a  (flag)     Query all positions in a read, not just minimizers. 
   --stride (int) Read stride (for multi-job alignment of the same file).
   -d 	(flag)     Enable dotPlot (debugging)
   --PrintNumAln (int)   Print out at most number of alignments for one read. (Use this option if want to print out secondary alignments) (DEFAULT: 1)
   --alnthres (float) Retain secondary alignments that have score at least this fraction to the primary alignment (DEFAULT: 0.7)
   --Al (int)      Compute at most number of alignments for one read. (DEFAULT: 3)
   --printMD      Write the MD tag in sam and paf output.
   --noMismatch   Use M instead of =/X in SAM/PAF output.
   --passthrough  Pass auxilary tags from the input unaligned bam to the output.
   --refineBreakpoints  Refine alignments of query sequence up to 500 bases near a breakpoint.
Examples: 
Aligning CCS reads:  lra align -CCS -t 16 ref.fa input.fasta/input.bam/input.sam -p s > output.sam
Aligning CLR reads:  lra align -CLR -t 16 ref.fa input.fasta/input.bam/input.sam -p s > output.sam
Aligning Nanopore reads:  lra align -ONT -t 16 ref.fa input.fasta/input.bam/input.sam -p s > output.sam
Aligning CONTIG:  lra align -CONIG -t 16 ref.fa input.fasta/input.bam/input.sam -p s > output.sam
```


## lra_global

### Tool Description
Index global reference for aligning reads or contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
- **Homepage**: https://github.com/ChaissonLab/LRA
- **Package**: https://anaconda.org/channels/bioconda/packages/lra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lra global file.fa [options]
Options: 
   -CCS (flag) Index for aligning CCS reads
   -CLR (flag) Index for aligning CLR reads
   -ONT (flag) Index for aligning Nanopore reads
   -CONTIG (flag) Index for aligning large contigs
   -W (int) Minimizer window size (10).
   -F (int) Maximum minimizer frequency. (default: 250 for CLR and ONT reads; 150 for CCS reads, 30 for CONTIG.)
   -K (int) Word size
   -h Print help.
Examples: 
Index global reference for aligning CCS reads: lra global -CCS ref.fa
Index global reference for aligning CLR reads: lra global -CLR ref.fa
Index global reference for aligning Nanopore reads: lra global -ONT ref.fa
Index global reference for aligning contig: lra global -CONTIG ref.fa
```


## lra_local

### Tool Description
Index global reference for aligning reads

### Metadata
- **Docker Image**: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
- **Homepage**: https://github.com/ChaissonLab/LRA
- **Package**: https://anaconda.org/channels/bioconda/packages/lra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lra global file.fa [options]
Options: 
   -CCS (flag) Index for aligning CCS reads
   -CLR (flag) Index for aligning CLR reads
   -ONT (flag) Index for aligning Nanopore reads
   -CONTIG (flag) Index for aligning large contigs
   -W (int) Minimizer window size (10).
   -F (int) Maximum minimizer frequency. (default: 250 for CLR and ONT reads; 150 for CCS reads, 30 for CONTIG.)
   -K (int) Word size
   -h Print help.
Examples: 
Index global reference for aligning CCS reads: lra global -CCS ref.fa
Index global reference for aligning CLR reads: lra global -CLR ref.fa
Index global reference for aligning Nanopore reads: lra global -ONT ref.fa
Index global reference for aligning contig: lra global -CONTIG ref.fa
```

