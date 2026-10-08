# haplotaglr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| haplotaglr_haplotag | Failed | image problem: samtools (and bgzip, tabix) are not installed in the image, and HaplotagLR calls samtools quickcheck on every BAM input, so the run stops with 'could not be read' |

## haplotaglr_haplotag

### Tool Description
Haplotag individual long reads using pre-phased haplotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplotaglr:1.1.13--pyhdfd78af_0
- **Homepage**: https://github.com/Boyle-Lab/HaplotagLR
- **Package**: https://anaconda.org/channels/bioconda/packages/haplotaglr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: HaplotagLR haplotag [-h] -v <VCF_FILE> -i <SAM/BAM/FASTQ>
                           [-o </path/to/output>] [-r <REF_FASTA>]
                           [-A <ASSEMBLY_NAME>] [-t <THREADS>] [-q] [-S]
                           [-O {combined,phase_tagged,full}]
                           [-s <SAMPLE_NAME>] [-e GLOBAL_EPSILON] [-c]
                           [-F FDR_THRESHOLD]
                           [--log_likelihood_threshold <MIN_LIKELIHOOD_RATIO>]
                           [--no_multcoeff]

A tool for haplotagging individual long reads using pre-phased haplotypes.

options:
  -h, --help            show this help message and exit

Required:
  Required for haplotag

  -v <VCF_FILE>, --vcf <VCF_FILE>
                        Path to vcf file with pre-phased haplotype data, in
                        VCF format. (Must be in .vcf.gz format with tabix
                        index in same folder. If .vcf file is provided, bgzip
                        and tabix must be installed and available on PATH
                        because HaplotagLR will attempt to convert it. EX: -v
                        GM12878_haplotype.vcf.gz)
  -i <SAM/BAM/FASTQ>, --input_reads <SAM/BAM/FASTQ>
                        Path to sequencing file (.fasta) or alignment file
                        (.bam or .sam) of long reads that will be used for
                        haplotagging. If either a .sam file is provided or an
                        index is not found, .sam and .bam file will be sorted
                        and indexed with SAMtools. Sorted.bam files should be
                        in same directory as their index (.sorted.bam.bai).
                        EX: -a data/minion_GM12878_run3.sorted.bam, -i
                        minion_GM12878_run3.sam) Path to long read file in
                        .fastq format that will be used for alignment and
                        haplotag (ex: -i minion_GM12878_run3.fastq). ****
                        NOTE: the -r/--reference argument is REQUIRED if using
                        input in fastq format! ****

Optional:
  Useful, but (mostly) not required for haplotagging.

  -o </path/to/output>, --output_directory_name </path/to/output>
                        Name given to directory where results will be output
                        (ex: -o minion_GM12878_run3_phasing_output)
  -r <REF_FASTA>, --reference <REF_FASTA>
                        Path to reference genome sequence file. REQUIRED if -i
                        is used to specify reads in fastq format to be aligned
                        prior to haplotagging. (file types allowed: .fa, .fna,
                        fasta. EX: -r data/reference_hg38.fna)
  -A <ASSEMBLY_NAME>, --reference_assembly <ASSEMBLY_NAME>
                        Assembly for the reference genome. EX: -A hg38.
  -t <THREADS>, --threads <THREADS>
                        Number of threads to use for mapping and indexing
                        steps.
  -q, --quiet           Output to stderr from subprocesses will be muted.
  -S, --silent          Output to stderr and stdout from subprocesses will be
                        muted.

Output options:
  Options for writing output to BAM file(s).

  -O {combined,phase_tagged,full}, --output_mode {combined,phase_tagged,full}
                        Specify whether/how haplotaggeded, untagged, and
                        nontaggable reads are printed to output. Modes
                        available: combined: All reads will be written to a
                        common output file. The phasing tag (HP:i:N) can be
                        used to extract maternal/paternal haplotagged reads,
                        untagged reads, and nontaggable reads. phase_tagged:
                        Haplotagged reads for both maternal and paternal
                        phases will be written to a single output file, while
                        untagged and nontaggable reads will be written to
                        their own respective output files. full: Maternal,
                        paternal, untagged, and nontaggable reads will be
                        printed to separate output files.
  -s <SAMPLE_NAME>, --one_sample <SAMPLE_NAME>
                        Use the --one_sample option to haplotag a specific
                        sample present in the input reads and vcf file. (-s
                        HG001)

Statistical options for haplotagging model:
  Options to modify thresholds and error parameters involved in haplotagging
  decisions.

  -e GLOBAL_EPSILON, --global_epsilon GLOBAL_EPSILON
                        Use a global value for the sequencing error rate,
                        epsilon. By default, epsilon is calculated per read as
                        the mean observed error rate. With --global_epsilon,
                        epsilon will be fixed at the given value when scoring
                        reads and in calculating the FDR threshold value for
                        the optional haplotagging error model (see
                        --FDR_threshold). By default, the gap-compressed per-
                        base divergence rate for each read will be used. These
                        are given directly in minimap2 under the 'de' tag, or
                        calculated from the pbmm2 'mg' tag as (100-mg)/100.
                        Supersedes --epsilon_from_quality_scores.
  -c, --epsilon_from_quality_scores
                        Obtain the sequencing error rate, epsilon, as per-base
                        observed error rates, calculated directly from Phred
                        scores in each BAM record. By default, the gap-
                        compressed per-base divergence rate for each read will
                        be used. These are given directly in minimap2 under
                        the 'de' tag, or calculated from the pbmm2 'mg' tag as
                        (100-mg)/100. Superseded by --global_epsilon.
  -F FDR_THRESHOLD, --FDR_threshold FDR_THRESHOLD
                        Control the false discovery rate at the given value
                        using a negative-binomial estimate of the number of
                        haplotagging errors (N) given the average per-base
                        sequencing error rate observed among all taggable
                        reads. Haplotagged reads are sorted by their observed
                        log-likelihood ratios and the bottom N*(1-FDR) reads
                        will be reassigned to the "Untagged" set. Set this to
                        zero to skip this step and return all haplotagging
                        predictions. Default = 0.
  --log_likelihood_threshold <MIN_LIKELIHOOD_RATIO>
                        Use a hard threshold on log-likelihood ratios when
                        haplotagging reads. Results will only be printed for
                        predicted haplotags with log-likelihood ratios equal
                        to or greater than this threshold. Setting this to
                        zero will cause all reads to be assigned to the phase
                        to which they share the greatest number matches. Log-
                        likelihood ratios will still be reported in the output
                        in this case, but are not used for haplotagging
                        decisions.
  --no_multcoeff        Do not apply the multinomial coefficient in the
                        likelihood calculation. Default=False (The multinomal
                        coefficient will be used.)
```

