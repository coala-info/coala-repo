# f5c CWL Generation Report

## f5c_index

### Tool Description
Build an index for accessing the base sequence (fastq/fasta) and raw signal (fast5/slow5) for a given read ID. f5c index is an extended and optimised version of nanopolish index by Jared Simpson

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Total Downloads**: 261.5K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/hasindu2008/f5c
- **Stars**: N/A
### Original Help Text
```text
Usage: f5c index [OPTIONS] -d fast5_directory reads.fastq
       f5c index [OPTIONS] --slow5 signals.blow5 reads.fastq

Build an index for accessing the base sequence (fastq/fasta) and raw signal (fast5/slow5) for a given read ID. f5c index is an extended and optimised version of nanopolish index by Jared Simpson

  -h                display this help and exit
  -d STR            path to the directory containing fast5 files. This option can be given multiple times.
  -s STR            the sequencing summary file
  -f STR            file containing the paths to the sequencing summary files (one per line)
  -t INT            number of threads used for bgzf compression (makes indexing faster)
  --iop INT         number of I/O processes to read fast5 files (makes fast5 indexing faster)
  --slow5 FILE      slow5 file containing raw signals
  --skip-slow5-idx  do not build the .idx for the slow5 file (useful when a slow5 index is already available)
  --verbose INT     verbosity level
  --version         print version

See the manual page for details (`man ./docs/f5c.1' or https://f5c.bioinf.science/man).
```


## f5c_call-methylation

### Tool Description
Call methylation from nanopore reads using f5c

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

### Original Help Text
```text
[meth_main::INFO][1;34m Default methylation tsv output format is changed from f5c v0.7 onwards to match latest nanopolish output. Set --meth-out-version=1 to fall back to the old format.[0m
Usage: f5c call-methylation [OPTIONS] -r reads.fa -b alignments.bam -g genome.fa
       f5c call-methylation [OPTIONS] -r reads.fa -b alignments.bam -g genome.fa --slow5 signals.blow5

basic options:
   -r FILE                    fastq/fasta read file
   -b FILE                    sorted bam file
   -g FILE                    reference genome
   -w STR                     limit processing to a genomic region specified as chr:start-end or a list of regions in a .bed file
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [5.0M]
   -h                         help
   -o FILE                    output to file [stdout]
   -x STR                     parameter profile to be used for better performance (always applied before other options)
                              e.g., laptop, desktop, hpc; see https://f5c.bioinf.science/profiles for the full list
   --iop INT                  number of I/O processes to read fast5 files [1]
   --pore STR                 set the pore chemistry (r9, r10 or rna004) [r9]
   --slow5 FILE               read from a slow5 file
   --min-mapq INT             minimum mapping quality [20]
   --secondary=yes|no         consider secondary mappings or not [no]
   --verbose INT              verbosity level [0]
   --version                  print version

advanced options:
   --skip-ultra FILE          skip ultra long reads and write those entries to the bam file provided as the argument
   --ultra-thresh INT         threshold to skip ultra long reads [100000]
   --skip-unreadable=yes|no   skip any unreadable fast5 or terminate program [yes]
   --kmer-model FILE          custom nucleotide k-mer model file (format similar to test/r9-models/r9.4_450bps.nucleotide.6mer.template.model)
   --meth-model FILE          custom methylation k-mer model file (format similar to test/r9-models/r9.4_450bps.cpg.6mer.template.model)
   --meth-out-version INT     methylation tsv output version (set 2 to print the strand column) [2]
   --min-recalib-events INT   minimum number of events to recalbrate (decrease if your reads are very short and could not calibrate) [200]

developer options:
   --print-events=yes|no      prints the event table
   --print-banded-aln=yes|no  prints the event alignment
   --print-scaling=yes|no     prints the estimated scalings
   --print-raw=yes|no         prints the raw signal
   --debug-break INT          break after processing the specified no. of batches
   --profile-cpu=yes|no       process section by section (used for profiling on CPU)
   --write-dump=yes|no        write the fast5 dump to a file or not
   --read-dump=yes|no         read from a fast5 dump file or not

See the manual page for details (`man ./docs/f5c.1' or https://f5c.bioinf.science/man).
```


## f5c_meth-freq

### Tool Description
Calculate methylation frequency from methylation calls

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: meth-freq [OPTIONS] -i methcalls.tsv

  -c FLOAT        call threshold for the log likelihood ratio. Default is 2.5. 
  -i FILE         input file. Read from stdin if not specified
  -o FILE         output file. Write to stdout if not specified
  -s              split groups
  -h              help
  --version       print version

See the manual page for details (`man ./docs/f5c.1' or https://f5c.bioinf.science/man).
```


## f5c_eventalign

### Tool Description
Align nanopore events to a reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: f5c eventalign [OPTIONS] -r reads.fa -b alignments.bam -g genome.fa
       f5c eventalign [OPTIONS] -r reads.fa -b alignments.bam -g genome.fa --slow5 signals.blow5

basic options:
   -r FILE                    fastq/fasta read file
   -b FILE                    sorted bam file
   -g FILE                    reference genome
   -w STR                     limit processing to a genomic region specified as chr:start-end or a list of regions in a .bed file
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [5.0M]
   -h                         help
   -o FILE                    output to file [stdout]
   -x STR                     parameter profile to be used for better performance (always applied before other options)
                              e.g., laptop, desktop, hpc; see https://f5c.bioinf.science/profiles for the full list
   --iop INT                  number of I/O processes to read fast5 files [1]
   --pore STR                 set the pore chemistry (r9, r10 or rna004) [r9]
   --slow5 FILE               read from a slow5 file
   --min-mapq INT             minimum mapping quality [20]
   --secondary=yes|no         consider secondary mappings or not [no]
   --verbose INT              verbosity level [0]
   --version                  print version

advanced options:
   --skip-ultra FILE          skip ultra long reads and write those entries to the bam file provided as the argument
   --ultra-thresh INT         threshold to skip ultra long reads [100000]
   --skip-unreadable=yes|no   skip any unreadable fast5 or terminate program [yes]
   --kmer-model FILE          custom nucleotide k-mer model file (format similar to test/r9-models/r9.4_450bps.nucleotide.6mer.template.model)
   --summary FILE             summarise the alignment of each read/strand in FILE
   --paf                      write output in PAF format
   --sam                      write output in SAM format
   --sam-out-version INT      sam output version (set 1 to revert to old nanopolish style format) [2]
   --m6anet                   write output in m6anet format
   --print-read-names         print read names instead of indexes
   --scale-events             scale events to the model, rather than vice-versa
   --samples                  write the raw samples for the event to the tsv output
   --signal-index             write the raw signal start and end index values for the event to the tsv output
   --rna                      the dataset is direct RNA
   --collapse-events          collapse events that stays on the same reference k-mer
   --min-recalib-events INT   minimum number of events to recalbrate (decrease if your reads are very short and could not calibrate) [200]

developer options:
   --print-events=yes|no      prints the event table
   --print-banded-aln=yes|no  prints the event alignment
   --print-scaling=yes|no     prints the estimated scalings
   --print-raw=yes|no         prints the raw signal
   --debug-break INT          break after processing the specified no. of batches
   --profile-cpu=yes|no       process section by section (used for profiling on CPU)
   --write-dump=yes|no        write the fast5 dump to a file or not
   --read-dump=yes|no         read from a fast5 dump file or not

See the manual page for details (`man ./docs/f5c.1' or https://f5c.bioinf.science/man).
```


## f5c_freq-merge

### Tool Description
Merge multiple methylation frequency files into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: f5c freq-merge [OPTIONS] input1.tsv input2.tsv ...
Merge multiple methylation frequency files into one.

   -o FILE         output file. Write to stdout if not specified
   -h              help
   --version       print version

See the manual page for details (`man ./docs/f5c.1' or https://f5c.bioinf.science/man).
```


## f5c_resquiggle

### Tool Description
f5c resquiggle aligns nanopore signals to reference sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/f5c:1.6--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/f5c
- **Package**: https://anaconda.org/channels/bioconda/packages/f5c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: f5c resquiggle [OPTIONS] reads.fastq signals.blow5

options:
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [5.0M]
   -h                         help
   -o FILE                    output to file [stdout]
   -x STR                     parameter profile to be used for better performance (always applied before other options)
                              e.g., laptop, desktop, hpc; see https://f5c.bioinf.science/profiles for the full list
   -c                         print in paf format
   --verbose INT              verbosity level [0]
   --version                  print version
   --kmer-model FILE          custom nucleotide k-mer model file (format similar to test/r9-models/r9.4_450bps.nucleotide.6mer.template.model)
   --rna                      the dataset is direct RNA
   --pore STR                 r9, r10 or rna004
```

