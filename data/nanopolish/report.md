# nanopolish CWL Generation Report

## nanopolish_call-methylation

### Tool Description
Classify nucleotides as methylated or not.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Total Downloads**: 153.2K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/jts/nanopolish
- **Stars**: N/A
### Original Help Text
```text
Usage: nanopolish call-methylation [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa --methylation cpg
Classify nucleotides as methylated or not.

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -r, --reads=FILE                     the ONT reads are in fasta/fastq FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the genome we are calling methylation for is in fasta FILE
  -q, --methylation=STRING             the type of methylation (cpg,gpc,dam,dcm)
  -o, --modbam-output-name=FILE        write the results as tags in FILE (default: tsv output)
  -s, --modbam-style=STRING            modbam output style either 'reference' or 'read' (default: read)
                                       when this is set to reference the SEQ field in the output will be the reference
                                       sequence spanned by the read
  -t, --threads=NUM                    use NUM threads (default: 1)
      --min-mapping-quality=NUM        only use reads with mapQ >= NUM (default: 20)
      --watch=DIR                      watch the sequencing run directory DIR and call methylation as data is generated
      --watch-write-bam                in watch mode, write the alignments for each fastq
  -c, --watch-process-total=TOTAL      in watch mode, there are TOTAL calling processes running against this directory
  -i, --watch-process-index=IDX        in watch mode, the index of this process is IDX
                                       the previous two options allow you to run multiple independent methylation
                                       calling processes against a single directory. Each process will only call
                                       files when X mod TOTAL == IDX, where X is the suffix of the fast5 file.
      --progress                       print out a progress message
  -K  --batchsize=NUM                  the batch size (default: 512)

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_detect-polyi

### Tool Description
Detect presence of poly(I) tails and estimate length of tails in direct RNA reads

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish detect-polyi [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Detect presence of poly(I) tails and estimate length of tails in direct RNA reads

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -w, --window=STR                     only compute the poly-A lengths for reads in window STR (format: ctg:start_id-end_id)
  -r, --reads=FILE                     the 1D ONT direct RNA reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the reference genome assembly for the reads is in FILE
  -t, --threads=NUM                    use NUM threads (default: 1)

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_eventalign

### Tool Description
Align nanopore events to reference k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish eventalign [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Align nanopore events to reference k-mers

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
      --sam                            write output in SAM format
  -w, --window=STR                     compute the consensus for window STR (format: ctg:start_id-end_id)
  -r, --reads=FILE                     the ONT reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the genome we are computing a consensus for is in FILE
  -t, --threads=NUM                    use NUM threads (default: 1)
  -q, --min-mapping-quality=NUM        only use reads with mapping quality at least NUM (default: 0)
      --scale-events                   scale events to the model, rather than vice-versa
      --progress                       print out a progress message
  -n, --print-read-names               print read names instead of indexes
      --summary=FILE                   summarize the alignment of each read/strand in FILE
      --samples                        write the raw samples for the event to the tsv output
      --signal-index                   write the raw signal start and end index values for the event to the tsv output
      --models-fofn=FILE               read alternative k-mer models from FILE

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_fast5-check

### Tool Description
Check whether the fast5 files are indexed correctly and readable by nanopolish

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish fast5-check [OPTIONS] -r reads.fastq
Check whether the fast5 files are indexed correctly and readable by nanopolish

      --help                           display this help and exit
      --version                        display version
  -r, --reads                          file containing the basecalled reads

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_index

### Tool Description
Build an index mapping from basecalled reads to the signals measured by the sequencer

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish index [OPTIONS] -d nanopore_raw_file_directory reads.fastq
Build an index mapping from basecalled reads to the signals measured by the sequencer

      --help                           display this help and exit
      --version                        display version
  -v, --verbose                        display verbose output
      --slow5 FILE                     slow5 file
  -d, --directory                      path to the directory containing the raw ONT signal files. This option can be given multiple times.
  -s, --sequencing-summary             the sequencing summary file from albacore, providing this option will make indexing much faster
  -f, --summary-fofn                   file containing the paths to the sequencing summary files (one per line)

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_methyltrain

### Tool Description
Train a methylation model

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish methyltrain [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Train a methylation model

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -m, --models-fofn=FILE               read the models to be trained from the FOFN
      --train-kmers=STR                train methylated, unmethylated or all kmers
  -c  --calibrate                      recalibrate aligned reads to model before training
      --no-update-models               do not write out trained models
      --output-scores                  optionally output read scores during training
  -r, --reads=FILE                     the ONT reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the reference genome is in FILE
  -t, --threads=NUM                    use NUM threads (default: 1)
      --filter-policy=STR              filter reads for [R7] or [R9] project
  -s, --out-suffix=STR                 name output files like <strand>.out_suffix
      --out-fofn=FILE                  write the names of the output models into FILE
      --rounds=NUM                     number of training rounds to perform
      --max-reads=NUM                  stop after processing NUM reads in each round
      --progress                       print out a progress message
      --stdv                           enable stdv modelling
      --max-events=NUM                 use NUM events for training (default: 1000)

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_phase-reads

### Tool Description
Output a BAM file where each record shows the combination of alleles from variants.vcf that each read supports. variants.vcf can be any VCF file but only SNPs will be phased and variants that have a homozygous reference genotype (0/0) will be skipped.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish phase-reads [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa variants.vcf
Output a BAM file where each record shows the combination of alleles from variants.vcf that each read supports.
variants.vcf can be any VCF file but only SNPs will be phased and variants that have a homozygous reference genotype (0/0)
will be skipped.

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -r, --reads=FILE                     the ONT reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the reference genome is in FILE
  -w, --window=STR                     only phase reads in the window STR (format: ctg:start-end)
  -t, --threads=NUM                    use NUM threads (default: 1)
      --progress                       print out a progress message

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_polya

### Tool Description
Estimate the length of the poly-A tail on direct RNA reads

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish polya [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Estimate the length of the poly-A tail on direct RNA reads

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -w, --window=STR                     only compute the poly-A lengths for reads in window STR (format: ctg:start_id-end_id)
  -r, --reads=FILE                     the 1D ONT direct RNA reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the reference genome assembly for the reads is in FILE
  -t, --threads=NUM                    use NUM threads (default: 1)

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_scorereads

### Tool Description
Score reads against an alignment, model

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish scorereads [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Score reads against an alignment, model

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -m, --models-fofn=FILE               optionally use these models rather than models in fast5
  -c  --calibrate                      recalibrate aligned reads to model before scoring
  -z  --zero-drift                     if recalibrating, keep drift at 0
  -i  --individual-reads=READ,READ     optional comma-delimited list of readnames to score
  -r, --reads=FILE                     the ONT reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the genome assembly are in bam FILE
  -g, --genome=FILE                    the genome we are computing a consensus for is in FILE
  -w, --window=STR                     score reads in the window STR (format: ctg:start-end)
  -t, --threads=NUM                    use NUM threads (default: 1)
      --train-transitions              train new transition parameters from the input reads

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_variants

### Tool Description
Find SNPs using a signal-level HMM

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish variants [OPTIONS] --reads reads.fa --bam alignments.bam --genome genome.fa
Find SNPs using a signal-level HMM

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
      --snps                           only call SNPs
      --consensus                      run in consensus calling mode
      --fix-homopolymers               run the experimental homopolymer caller
      --faster                         minimize compute time while slightly reducing consensus accuracy
  -w, --window=STR                     find variants in window STR (format: <chromsome_name>:<start>-<end>)
  -r, --reads=FILE                     the ONT reads are in fasta FILE
  -b, --bam=FILE                       the reads aligned to the reference genome are in bam FILE
  -e, --event-bam=FILE                 the events aligned to the reference genome are in bam FILE
  -g, --genome=FILE                    the reference genome is in FILE
  -p, --ploidy=NUM                     the ploidy level of the sequenced genome
  -q  --methylation-aware=STR          turn on methylation aware polishing and test motifs given in STR (example: -q dcm,dam)
      --genotype=FILE                  call genotypes for the variants in the vcf FILE
  -o, --outfile=FILE                   write result to FILE [default: stdout]
  -t, --threads=NUM                    use NUM threads (default: 1)
  -m, --min-candidate-frequency=F      extract candidate variants from the aligned reads when the variant frequency is at least F (default 0.2)
  -i, --indel-bias=F                   bias HMM transition parameters to favor insertions (F<1) or deletions (F>1).
                                       this value is automatically set depending on --consensus, but can be manually set if spurious indels are called
  -d, --min-candidate-depth=D          extract candidate variants from the aligned reads when the depth is at least D (default: 20)
  -x, --max-haplotypes=N               consider at most N haplotype combinations (default: 1000)
      --min-flanking-sequence=N        distance from alignment end to calculate variants (default: 30)
      --max-rounds=N                   perform N rounds of consensus sequence improvement (default: 50)
  -c, --candidates=VCF                 read variant candidates from VCF, rather than discovering them from aligned reads
      --read-group=RG                  only use alignments with read group tag RG
  -a, --alternative-basecalls-bam=FILE if an alternative basecaller was used that does not output event annotations
                                       then use basecalled sequences from FILE. The signal-level events will still be taken from the -b bam.
      --calculate-all-support          when making a call, also calculate the support of the 3 other possible bases
      --models-fofn=FILE               read alternative k-mer models from FILE

Report bugs to https://github.com/jts/nanopolish/issues
```


## nanopolish_vcf2fasta

### Tool Description
Write a new genome sequence by introducing variants from the input files

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
- **Homepage**: https://github.com/jts/nanopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopolish/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nanopolish vcf2fasta -g draft.fa segment1.vcf segment2.vcf ...
Write a new genome sequence by introducing variants from the input files

  -v, --verbose                        display verbose output
      --version                        display version
      --help                           display this help and exit
  -g, --genome=FILE                    the input genome is in FILE
  -f, --fofn=FILE                      read the list of VCF files to use from FILE
      --skip-checks                    skip the sanity checks

Report bugs to https://github.com/jts/nanopolish/issues
```

