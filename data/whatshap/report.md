# whatshap CWL Generation Report

## whatshap_compare

### Tool Description
Compare two or more phased variant files

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Total Downloads**: 222.9K
- **Last updated**: 2025-06-09
- **GitHub**: https://github.com/whatshap/whatshap
- **Stars**: N/A
### Original Help Text
```text
usage: whatshap compare [-h] [--sample SAMPLE] [--names NAMES]
                        [--ignore-sample-name] [--tsv-pairwise TSVPAIRWISE]
                        [--tsv-multiway TSVMULTIWAY] [--only-snvs]
                        [--switch-error-bed SWITCH_ERROR_BED]
                        [--plot-blocksizes PLOT_BLOCKSIZES]
                        [--plot-sum-of-blocksizes PLOT_SUM_OF_BLOCKSIZES]
                        [--longest-block-tsv LONGEST_BLOCK_TSV]
                        [--ploidy PLOIDY]
                        VCF/BCF [VCF/BCF ...]

Compare two or more phased variant files

positional arguments:
  VCF/BCF               At least two phased variant files (VCF or BCF) to be
                        compared.

optional arguments:
  -h, --help            show this help message and exit
  --sample SAMPLE       Name of the sample to process. If not given, use first
                        sample found in VCF.
  --names NAMES         Comma-separated list of data set names to be used in
                        the report (in same order as VCFs).
  --ignore-sample-name  For single sample VCFs, ignore sample name and assume
                        all samples are the same.
  --tsv-pairwise TSVPAIRWISE
                        Filename to write comparison results from pair-wise
                        comparison to (tab-separated).
  --tsv-multiway TSVMULTIWAY
                        Filename to write comparison results from multiway
                        comparison to (tab-separated). Only for diploid VCFs.
  --only-snvs           Only process SNVs and ignore all other variants.
  --switch-error-bed SWITCH_ERROR_BED
                        Write BED file with switch error positions to given
                        filename. Only for diploid VCFs.
  --plot-blocksizes PLOT_BLOCKSIZES
                        Write PDF file with a block length histogram to given
                        filename (requires matplotlib).
  --plot-sum-of-blocksizes PLOT_SUM_OF_BLOCKSIZES
                        Write PDF file with a block length histogram in which
                        the height of each bar corresponds to the sum of
                        lengths.
  --longest-block-tsv LONGEST_BLOCK_TSV
                        Write position-wise agreement of longest joint blocks
                        in each chromosome to tab-separated file. Only for
                        diploid VCFs.
  --ploidy PLOIDY, -p PLOIDY
                        The ploidy of the sample(s) (default: 2).
whatshap compare: error: argument -h/--help: ignored explicit argument 'elp'
```


## whatshap_find_snv_candidates

### Tool Description
Generate candidate SNP positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap find_snv_candidates [-h] [--minabs MIN_ABS] [--minrel MIN_REL]
                                    [--multi-allelics] [--sample SAMPLE]
                                    [--chromosome CHROMOSOME] [-o OUTPUT]
                                    [--pacbio | --nanopore | --illumina]
                                    REF BAM

Generate candidate SNP positions.

positional arguments:
  REF                   FASTA with reference genome
  BAM                   BAM file

optional arguments:
  -h, --help            show this help message and exit
  --minabs MIN_ABS      Minimum absolute ALT depth to call a SNP (default: 3).
  --minrel MIN_REL      Minimum relative ALT depth to call a SNP (default:
                        0.25).
  --multi-allelics      Also output multi-allelic sites, if not given only the
                        best ALT allele is reported (if unique).
  --sample SAMPLE       Put this sample column into VCF (default: output
                        sites-only VCF).
  --chromosome CHROMOSOME
                        Name of chromosome to process. If not given, all
                        chromosomes are processed.
  -o OUTPUT, --output OUTPUT
                        Output VCF file.
  --pacbio              Input is PacBio. Sets minrel=0.25 and minabs=3.
  --nanopore            Input is Nanopore. Sets minrel=0.4 and minabs=3.
  --illumina            Input is Illumina. Sets minrel=0.25 and minabs=3.
whatshap find_snv_candidates: error: argument -h/--help: ignored explicit argument 'elp'
```


## whatshap_genotype

### Tool Description
Genotype variants

Runs only the genotyping algorithm. Genotype Likelihoods are computed using the
forward backward algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap genotype [-h] [-o OUTPUT] [--reference FASTA]
                         [--max-coverage MAXCOV] [--mapping-quality QUAL]
                         [--only-snvs] [--ignore-read-groups]
                         [--sample SAMPLE] [--chromosome CHROMOSOME]
                         [--exclude-chromosome EXCLUDED_CHROMOSOMES]
                         [--gt-qual-threshold GTQUALTHRESHOLD] [--no-priors]
                         [-p PRIOROUTPUT] [--overhang OVERHANG]
                         [--constant CONSTANT] [--affine-gap]
                         [--gap-start GAPSTART] [--gap-extend GAPEXTEND]
                         [--mismatch MISMATCH] [--ped PED/FAM]
                         [--recombrate RECOMBRATE] [--genmap FILE]
                         [--use-ped-samples] [--use-kmerald]
                         [--kmeralign-costs COSTS] [--kmer-size KMER]
                         [--kmerald-gappenalty GAP] [--kmerald-window WINDOW]
                         VCF [PHASEINPUT ...]

Genotype variants

Runs only the genotyping algorithm. Genotype Likelihoods are computed using the
forward backward algorithm.

positional arguments:
  VCF                   VCF file with variants to be genotyped (can be gzip-
                        compressed)
  PHASEINPUT            BAM or VCF file(s) with phase information, either
                        through sequencing reads (BAM) or through phased
                        blocks (VCF)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output VCF file. Add .gz to the file name to get
                        compressed output. If omitted, use standard output.
  --reference FASTA, -r FASTA
                        Reference file. Provide this to detect alleles through
                        re-alignment. If no index (.fai) exists, it will be
                        created

Input pre-processing, selection and filtering:
  --max-coverage MAXCOV, -H MAXCOV
                        Reduce coverage to at most MAXCOV (default: 15).
  --mapping-quality QUAL, --mapq QUAL
                        Minimum mapping quality (default: 20)
  --only-snvs           Genotype only SNVs
  --ignore-read-groups  Ignore read groups in BAM header and assume all reads
                        come from the same sample.
  --sample SAMPLE       Name of a sample to genotype. If not given, all
                        samples in the input VCF are genotyped. Can be used
                        multiple times.
  --chromosome CHROMOSOME
                        Name of chromosome to genotyped. If not given, all
                        chromosomes in the input VCF are genotyped. Can be
                        used multiple times.
  --exclude-chromosome EXCLUDED_CHROMOSOMES
                        Name of chromosome not to be genotyped.
  --gt-qual-threshold GTQUALTHRESHOLD
                        Phred scaled error probability threshold used for
                        genotyping (default: 0). Must be at least 0. If error
                        probability of genotype is higher, genotype ./. is
                        output.
  --no-priors           Skip initial prior genotyping and use uniform priors
                        (default: False).
  -p PRIOROUTPUT, --prioroutput PRIOROUTPUT
                        output prior genotype likelihoods to the given file.
  --overhang OVERHANG   When --reference is used, extend alignment by this
                        many bases to left and right when realigning (default:
                        10).
  --constant CONSTANT   This constant is used to regularize the priors
                        (default: 0).
  --affine-gap          When detecting alleles through re-alignment, use
                        affine gap costs (EXPERIMENTAL).
  --gap-start GAPSTART  gap starting penalty in case affine gap costs are used
                        (default: 10).
  --gap-extend GAPEXTEND
                        gap extend penalty in case affine gap costs are used
                        (default: 7).
  --mismatch MISMATCH   mismatch cost in case affine gap costs are used
                        (default: 15)

Pedigree genotyping:
  --ped PED/FAM         Use pedigree information in PED file to improve
                        genotyping (switches to PedMEC algorithm). Columns 2,
                        3, 4 must refer to child, father, and mother sample
                        names as used in the VCF and BAM. Other columns are
                        ignored (EXPERIMENTAL).
  --recombrate RECOMBRATE
                        Recombination rate in cM/Mb (used with --ped). If
                        given, a constant recombination rate is assumed
                        (default: 1.26cM/Mb).
  --genmap FILE         File with genetic map (used with --ped) to be used
                        instead of constant recombination rate, i.e. overrides
                        option --recombrate.
  --use-ped-samples     Only work on samples mentioned in the provided PED
                        file.

kmerald based genotyping:
  --use-kmerald         Use kmerald for detecting alleles through re-
                        alignment.
  --kmeralign-costs COSTS
                        Error model based costs used by kmerald during re-
                        alignment.
  --kmer-size KMER      kmer size used by kmerald during re-alignment.
  --kmerald-gappenalty GAP
                        Gap penalty used by kmerald during re-alignment.
  --kmerald-window WINDOW
                        Consider this many bases on the left and side of a
                        variant position for kmerald based re-alignment.
whatshap genotype: error: the following arguments are required: VCF, PHASEINPUT
```


## whatshap_hapcut2vcf

### Tool Description
Convert hapCUT output format to VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap hapcut2vcf [-h] [-o OUTPUT] VCF HAPCUT-RESULT

Convert hapCUT output format to VCF

HapCUT’s output is combined with the original VCF and
then written as phased VCF to standard output.

HapCUT 1 and 2 are supported.

HapCUT’s output file format is explained at
<https://github.com/vibansal/hapcut#format-of-input-and-output-files>

HapCUT2’s output format is documented at
<https://github.com/pjedge/hapcut2#output-format>

positional arguments:
  VCF                   VCF file
  HAPCUT-RESULT         hapCUT result file

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output VCF file. If omitted, use standard output.
whatshap hapcut2vcf: error: the following arguments are required: VCF, HAPCUT-RESULT
```


## whatshap_haplotag

### Tool Description
Tag reads by haplotype

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap haplotag [-h] [-o OUTPUT] [--reference FASTA] [--no-reference]
                         [--regions REGION] [--ignore-linked-read]
                         [--linked-read-distance-cutoff LINKEDREADDISTANCE]
                         [--ignore-read-groups] [--sample SAMPLE]
                         [--output-haplotag-list HAPLOTAG_LIST]
                         [--tag-supplementary [{skip,copy-primary,independent-or-skip,independent-or-copy-primary}]]
                         [--supplementary-distance SUPPLEMENTARY_DISTANCE_THRESHOLD]
                         [--no-supplementary-strand-match] [--ploidy PLOIDY]
                         [--skip-missing-contigs]
                         [--output-threads OUTPUT_THREADS]
                         VCF ALIGNMENTS

Tag reads by haplotype

Sequencing reads are read from file ALIGNMENTS (in BAM or CRAM format) and tagged reads
are written to stdout.

positional arguments:
  VCF                   VCF file with phased variants (must be gzip-compressed
                        and indexed)
  ALIGNMENTS            BAM/CRAM file with alignments to be tagged by
                        haplotype

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file. If omitted, use standard output.
  --reference FASTA, -r FASTA
                        Reference file. Must be accompanied by .fai index
                        (create with samtools faidx)
  --no-reference        Detect alleles without requiring a reference, at the
                        expense of phasing quality (in particular for long
                        reads)
  --regions REGION      Specify region(s) of interest to limit the tagging to
                        reads/variants overlapping those regions. You can
                        specify a space-separated list of regions in the form
                        of chrom:start-end, chrom (consider entire
                        chromosome), or chrom:start (consider region from this
                        start to end of chromosome).
  --ignore-linked-read  Ignore linkage information stored in BX tags of the
                        reads.
  --linked-read-distance-cutoff LINKEDREADDISTANCE, -d LINKEDREADDISTANCE
                        Assume reads with identical BX tags belong to
                        different read clouds if their distance is larger than
                        LINKEDREADDISTANCE (default: 50000).
  --ignore-read-groups  Ignore read groups in BAM/CRAM header and assume all
                        reads come from the same sample.
  --sample SAMPLE       Name of a sample to phase. If not given, all samples
                        in the input VCF are phased. Can be used multiple
                        times.
  --output-haplotag-list HAPLOTAG_LIST
                        Write assignments of read names to haplotypes (tab
                        separated) to given output file. If filename ends in
                        .gz, then output is gzipped.
  --tag-supplementary [{skip,copy-primary,independent-or-skip,independent-or-copy-primary}]
                        How to tag supplementary alignments. `skip`: do not
                        tag; `copy-primary` or value omitted: tag same as
                        primary; `independent-or-skip`: treat as independent
                        alignment; `independent-or-copy-primary`: treat as
                        independent alignment, but if fails, tag same as
                        primary. Default: skip
  --supplementary-distance SUPPLEMENTARY_DISTANCE_THRESHOLD
                        Maximum distance between supplementary alignment
                        record and a primary one for the tag copying onto the
                        supplementary to be attempted. (default: 100,000)
  --no-supplementary-strand-match
                        Allow for strands missmatch between supplementary and
                        primary alignment records during the tag copying onto
                        the supplementary.
  --ploidy PLOIDY       Ploidy (default: 2).
  --skip-missing-contigs
                        Skip reads that map to a contig that does not exist in
                        the VCF
  --output-threads OUTPUT_THREADS, --out-threads OUTPUT_THREADS
                        Number of threads to use for output file writing
                        (passed to pysam). For optimal performance, instead
                        pipe output into 'samtools view' to compress.
whatshap haplotag: error: the following arguments are required: VCF, ALIGNMENTS
```


## whatshap_haplotagphase

### Tool Description
Phase variants in VCF based on information from haplotagged reads

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap haplotagphase [-h] [-o OUTPUT] [--reference FASTA]
                              [--gap-threshold PERCENT] [--cut-poly LENGTH]
                              [--only-indels] [--sample SAMPLE]
                              [--ignore-read-groups] [--chromosome CHROMOSOME]
                              [--no-mav]
                              [--exclude-chromosome EXCLUDED_CHROMOSOMES]
                              VCF ALIGNMENTS

Phase variants in VCF based on information from haplotagged reads

positional arguments:
  VCF                   VCF file with variants to phase (must be gzip-
                        compressed and indexed)
  ALIGNMENTS            BAM/CRAM file with alignments tagged by haplotype and
                        phase set

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file. If omitted, use standard output.
  --reference FASTA, -r FASTA
                        Reference file. Must be accompanied by .fai index
                        (create with samtools faidx)
  --gap-threshold PERCENT, -g PERCENT
                        Threshold percentage for qualities. If the percentage
                        of votes for the variant is less than this value, the
                        algorithm does not assign any information to the
                        variant.
  --cut-poly LENGTH, -c LENGTH
                        Ignore variants within homopolymers longer than the
                        cut value.
  --only-indels, -i     Add phasing information only to indels.
  --sample SAMPLE       Name of a sample to phase. If not given, all samples
                        in the input VCF are phased. Can be used multiple
                        times.
  --ignore-read-groups  Ignore read groups in BAM/CRAM header and assume all
                        reads come from the same sample.
  --chromosome CHROMOSOME
                        Name of chromosome to phase. If not given, all
                        chromosomes in the input VCF are phased. Can be used
                        multiple times.
  --no-mav              Ignore multiallelic variants.
  --exclude-chromosome EXCLUDED_CHROMOSOMES
                        Name of chromosome not to phase.
whatshap haplotagphase: error: the following arguments are required: VCF, ALIGNMENTS
```


## whatshap_learn

### Tool Description
Generate sequencing technology specific error profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap learn [-h] --reference FASTA [-k K] [--window WINDOW] --output
                      OUT
                      BAM VCF

Generate sequencing technology specific error profiles

positional arguments:
  BAM                   Read alignments
  VCF                   List of variants

optional arguments:
  -h, --help            show this help message and exit
  --reference FASTA, -r FASTA
                        Reference genome
  -k K, --kmer K        k-mer size
  --window WINDOW, -w WINDOW
                        Ignore this many bases on the left and right of each
                        variant position
  --output OUT, -o OUT  Output file with kmer-pair counts
whatshap learn: error: the following arguments are required: BAM, VCF, --reference/-r, --output/-o
```


## whatshap_phase

### Tool Description
Phase variants in a VCF with the WhatsHap algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap phase [-h] [-o OUTPUT] [--reference FASTA] [--no-reference]
                      [--tag {PS,HP}] [--output-read-list FILE]
                      [--algorithm {whatshap,hapchat,heuristic}]
                      [--merge-reads] [--row-limit ROWLIMIT]
                      [--internal-downsampling COVERAGE]
                      [--mapping-quality QUAL] [--only-snvs]
                      [--ignore-read-groups] [--sample SAMPLE]
                      [--chromosome CHROMOSOME]
                      [--exclude-chromosome EXCLUDED_CHROMOSOMES]
                      [--error-rate READ_MERGING_ERROR_RATE]
                      [--maximum-error-rate READ_MERGING_MAX_ERROR_RATE]
                      [--threshold READ_MERGING_POSITIVE_THRESHOLD]
                      [--negative-threshold READ_MERGING_NEGATIVE_THRESHOLD]
                      [--distrust-genotypes] [--include-homozygous]
                      [--default-gq DEFAULT_GQ]
                      [--gl-regularizer GL_REGULARIZER]
                      [--changed-genotype-list FILE] [--ped PED/FAM]
                      [--recombination-list FILE] [--recombrate RECOMBRATE]
                      [--genmap FILE] [--no-genetic-haplotyping]
                      [--use-ped-samples] [--use-supplementary]
                      [--supplementary-distance DIST]
                      VCF [PHASEINPUT ...]

Phase variants in a VCF with the WhatsHap algorithm

Read a VCF and one or more files with phase information (BAM/CRAM or VCF phased
blocks) and phase the variants. The phased VCF is written to standard output.

positional arguments:
  VCF                   VCF or BCF file with variants to be phased (can be
                        gzip-compressed)
  PHASEINPUT            BAM, CRAM, VCF or BCF file(s) with phase information,
                        either through sequencing reads (BAM, CRAM) or through
                        phased blocks (VCF, BCF)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output VCF file. Add .gz to the file name to get
                        compressed output. If omitted, use standard output.
  --reference FASTA, -r FASTA
                        Reference file. Must be accompanied by .fai index
                        (create with samtools faidx)
  --no-reference        Detect alleles without requiring a reference, at the
                        expense of phasing quality (in particular for long
                        reads)
  --tag {PS,HP}         Store phasing information with PS tag (standardized)
                        or HP tag (used by GATK ReadBackedPhasing) (default:
                        PS)
  --output-read-list FILE
                        Write reads that have been used for phasing to FILE.
  --algorithm {whatshap,hapchat,heuristic}
                        Phasing algorithm to use (default: whatshap)

Input pre-processing, selection and filtering:
  --merge-reads         Merge reads which are likely to come from the same
                        haplotype (default: do not merge reads)
  --row-limit ROWLIMIT, -L ROWLIMIT
                        For the heuristic: Maximum number of memorized
                        intermediate solutions. Larger values increase runtime
                        and memory consumption, but can improve phasing
                        quality. (default: None)
  --internal-downsampling COVERAGE
                        Coverage reduction parameter in the internal core
                        phasing algorithm. Higher values increase runtime
                        *exponentially* while possibly improving phasing
                        quality marginally. Avoid using this in the normal
                        case! (default: 15)
  --mapping-quality QUAL, --mapq QUAL
                        Minimum mapping quality (default: 20)
  --only-snvs           Phase only SNVs
  --ignore-read-groups  Ignore read groups in BAM/CRAM header and assume all
                        reads come from the same sample.
  --sample SAMPLE       Name of a sample to phase. If not given, all samples
                        in the input VCF are phased. Can be used multiple
                        times.
  --chromosome CHROMOSOME
                        Name of chromosome to phase. If not given, all
                        chromosomes in the input VCF are phased. Can be used
                        multiple times.
  --exclude-chromosome EXCLUDED_CHROMOSOMES
                        Name of chromosome not to phase.

Read merging:
  The options in this section are only active when --merge-reads is used

  --error-rate READ_MERGING_ERROR_RATE
                        The probability that a nucleotide is wrong in read
                        merging model (default: 0.15).
  --maximum-error-rate READ_MERGING_MAX_ERROR_RATE
                        The maximum error rate of any edge of the read merging
                        graph before discarding it (default: 0.25).
  --threshold READ_MERGING_POSITIVE_THRESHOLD
                        The threshold of the ratio between the probabilities
                        that a pair of reads come from the same haplotype and
                        different haplotypes in the read merging model
                        (default: 1000000).
  --negative-threshold READ_MERGING_NEGATIVE_THRESHOLD
                        The threshold of the ratio between the probabilities
                        that a pair of reads come from different haplotypes
                        and the same haplotype in the read merging model
                        (default: 1000).

Genotyping:
  These options are only used when --distrust-genotypes is used

  --distrust-genotypes  Allow switching variants from hetero- to homozygous in
                        an optimal solution (see documentation).
  --include-homozygous  Also work on homozygous variants, which might be
                        turned to heterozygous
  --default-gq DEFAULT_GQ
                        Default genotype quality used as cost of changing a
                        genotype when no genotype likelihoods are available
                        (default 30)
  --gl-regularizer GL_REGULARIZER
                        Constant (float) to be used to regularize genotype
                        likelihoods read from input VCF (default None).
  --changed-genotype-list FILE
                        Write list of changed genotypes to FILE.

Pedigree phasing:
  --ped PED/FAM         Use pedigree information in PED file to improve
                        phasing (switches to PedMEC algorithm). Columns 2, 3,
                        4 must refer to child, father, and mother sample names
                        as used in the VCF and BAM/CRAM. Other columns are
                        ignored.
  --recombination-list FILE
                        Write putative recombination events to FILE.
  --recombrate RECOMBRATE
                        Recombination rate in cM/Mb (used with --ped). If
                        given, a constant recombination rate is assumed
                        (default: 1.26cM/Mb).
  --genmap FILE         File with genetic map (used with --ped) to be used
                        instead of constant recombination rate, i.e. overrides
                        option --recombrate.
  --no-genetic-haplotyping
                        Do not merge blocks that are not connected by reads
                        (i.e. solely based on genotype status). Default: when
                        in --ped mode, merge all blocks that contain at least
                        one homozygous genotype in at least one individual
                        into one block.
  --use-ped-samples     Only work on samples mentioned in the provided PED
                        file.
  --use-supplementary   Use also supplementary alignments (default: ignore
                        supplementary_ alignments)
  --supplementary-distance DIST
                        Skip supplementary alignments further than DIST bp
                        away from the primary alignment (default: 100000)
whatshap phase: error: the following arguments are required: VCF, PHASEINPUT
```


## whatshap_polyphase

### Tool Description
Phase variants in a polyploid VCF using a clustering+threading algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap polyphase [-h] [-o OUTPUT] [--reference FASTA] [--tag {PS,HP}]
                          [--mapping-quality QUAL] [--only-snvs]
                          [--ignore-read-groups] [--include-haploid-sets]
                          [--sample SAMPLE] [--chromosome CHROMOSOME]
                          [--exclude-chromosome EXCLUDED_CHROMOSOMES]
                          [--distrust-genotypes] --ploidy PLOIDY
                          [--use-prephasing] [--min-overlap OVERLAP]
                          [--block-cut-sensitivity SENSITIVITY]
                          [--threads THREADS] [--no-mav] [--use-supplementary]
                          [--supplementary-distance DIST]
                          VCF [PHASEINPUT ...]

Phase variants in a polyploid VCF using a clustering+threading algorithm.

Read a VCF and one or more files with phase information (BAM/CRAM or VCF phased
blocks) and phase the variants. The phased VCF is written to standard output.
Requires to specify a ploidy for the phasable input. Allows to specify a block
cut sensitivity to balance out length and accuracy of phased blocks.

positional arguments:
  VCF                   VCF file with variants to be phased (can be gzip-
                        compressed)
  PHASEINPUT            BAM or CRAM with sequencing reads.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output VCF file. Add .gz to the file name to get
                        compressed output. If omitted, use standard output.
  --reference FASTA, -r FASTA
                        Reference file. Provide this to detect alleles through
                        re-alignment. If no index (.fai) exists, it will be
                        created
  --tag {PS,HP}         Store phasing information with PS tag (standardized)
                        or HP tag (used by GATK ReadBackedPhasing) (default:
                        PS)

Input pre-processing, selection, and filtering:
  --mapping-quality QUAL, --mapq QUAL
                        Minimum mapping quality (default: 20)
  --only-snvs           Only phase SNVs
  --ignore-read-groups  Ignore read groups in BAM/CRAM header and assume all
                        reads come from the same sample.
  --include-haploid-sets
                        Include the phase set information for every single
                        haplotype in a custom VCF format field 'HS'.
  --sample SAMPLE       Name of a sample to phase. If not given, all samples
                        in the input VCF are phased. Can be used multiple
                        times.
  --chromosome CHROMOSOME
                        Name of chromosome to phase. If not given, all
                        chromosomes in the input VCF are phased. Can be used
                        multiple times.
  --exclude-chromosome EXCLUDED_CHROMOSOMES
                        Name of chromosome not to phase.
  --distrust-genotypes  Allows the phaser to change genotypes if beneficial
                        for the internal model.

Parameters for phasing steps:
  --ploidy PLOIDY, -p PLOIDY
                        The ploidy of the sample(s). Argument is required.
  --use-prephasing      Uses existing phase set blocks in the input to
                        increase contiguity of phasing output.
  --min-overlap OVERLAP
                        Minimum required read overlap for internal read
                        clustering stage (default: 2).
  --block-cut-sensitivity SENSITIVITY, -B SENSITIVITY
                        Strategy to determine block borders. 0 yields the
                        longest blocks with more switch errors, 5 has the
                        shortest blocks with lowest switch error rate
                        (default: 4).
  --threads THREADS, -t THREADS
                        Maximum number of CPU threads used (default: 1).
  --no-mav              Disables phasing of multi-allelic variants.
  --use-supplementary   Use also supplementary alignments (default: ignore
                        supplementary_ alignments)
  --supplementary-distance DIST
                        Skip supplementary alignments further than DIST bp
                        away from the primary alignment (default: 100000)
whatshap polyphase: error: the following arguments are required: VCF, PHASEINPUT, --ploidy/-p
```


## whatshap_polyphasegenetic

### Tool Description
Phase variants in a polyploid VCF using a clustering+threading algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap polyphasegenetic [-h] [-P PROGENY_FILE] [-o OUTPUT]
                                 [--tag {PS,HP}] [--only-snvs]
                                 [--sample SAMPLE] [--chromosome CHROMOSOME]
                                 [--exclude-chromosome EXCLUDED_CHROMOSOMES]
                                 --ploidy PLOIDY
                                 [--scoring-window SCORINGWINDOW]
                                 [--complexity-support COMPLEXITY_SUPPORT]
                                 [--distrust-genotypes]
                                 VCF PEDIGREE

Phase variants in a polyploid VCF using a clustering+threading algorithm.

Read a VCF and one or more files with phase information (BAM/CRAM or VCF phased
blocks) and phase the variants. The phased VCF is written to standard output.
Requires to specify a ploidy for the phasable input. Allows to specify a block
cut sensitivity to balance out length and accuracy of phased blocks.

positional arguments:
  VCF                   VCF file with variants to be phased (can be gzip-
                        compressed)
  PEDIGREE              Pedigree file.

optional arguments:
  -h, --help            show this help message and exit
  -P PROGENY_FILE, --progeny_file PROGENY_FILE
                        File with progeny genotypes. If not specified,
                        information is taken from main input file.
  -o OUTPUT, --output OUTPUT
                        Output VCF file. Add .gz to the file name to get
                        compressed output. If omitted, use standard output.
  --tag {PS,HP}         Store phasing information with PS tag (standardized)
                        or HP tag (used by GATK ReadBackedPhasing) (default:
                        PS)

Input pre-processing, selection, and filtering:
  --only-snvs           Phase only SNVs
  --sample SAMPLE       Name of a sample to phase. If not given, all samples
                        in the input VCF are phased. Can be used multiple
                        times.
  --chromosome CHROMOSOME
                        Name of chromosome to phase. If not given, all
                        chromosomes in the input VCF are phased. Can be used
                        multiple times.
  --exclude-chromosome EXCLUDED_CHROMOSOMES
                        Name of chromosome not to phase.

Parameters for phasing steps:
  --ploidy PLOIDY, -p PLOIDY
                        The ploidy of the sample(s). Argument is required.
  --scoring-window SCORINGWINDOW
                        Size of the window (in variants) for statistical
                        progeny scoring.
  --complexity-support COMPLEXITY_SUPPORT, -C COMPLEXITY_SUPPORT
                        Indicates what level of genotype complexity is allowed
                        for phased variants. 0 = simplex-nulliplex only, 1 =
                        simplex-simplex on top, 2 = duplex-nulliplex on top.
                        Default is 0.
  --distrust-genotypes  Internally retypes the reported parent genotypes based
                        on allele distribution in progeny samples.
whatshap polyphasegenetic: error: the following arguments are required: VCF, PEDIGREE, --ploidy/-p
```


## whatshap_split

### Tool Description
Split reads by haplotype

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap split [-h] [--output-h1 FILE] [--output-h2 FILE]
                      [--output FILE] [--output-untagged OUTPUT_UNTAGGED]
                      [--add-untagged] [--only-largest-block]
                      [--discard-unknown-reads]
                      [--read-lengths-histogram READ_LENGTHS_HISTOGRAM]
                      READS LIST

Split reads by haplotype

This subcommand reads either a FASTQ or a BAM file and a list of haplotype assignments
(such as generated by whatshap haplotag --output-haplotag-list); it then outputs one
FASTQ or BAM per haplotype.

1. BAM mode is intended for unmapped BAMs (such as provided by PacBio).
2. The output format is the same as the input format (FASTQ or BAM).
  (Reading BAM but writing FASTQ or vice versa is not possible.)

Examples:

    whatshap split --output-h1 h1.fastq.gz --output-h2 h2.fastq.gz reads.fastq.gz haplotypes.txt
    whatshap split --output-h1 h1.bam --output-h2 h2.bam reads.bam haplotypes.txt

Tetraploid:

    whatshap split -o h1.bam -o h2.bam -o h3.bam -o h4.bam reads.bam haplotypes.txt

positional arguments:
  READS                 Input FASTQ/BAM file with reads (FASTQ can be gzipped)
  LIST                  Tab-separated list with (at least) two columns
                        <readname> and <haplotype> (can be gzipped).
                        Currently, the haplotypes have to be named H1, H2,
                        etc. (or none). Alternatively, the output of the
                        "haplotag" command can be used (4 columns), and this
                        is required for using the "--only-largest-block"
                        option (need phaseset and chromosome info).

optional arguments:
  -h, --help            show this help message and exit
  --output-h1 FILE      Output haplotype 1 reads to FILE (.gz supported)
  --output-h2 FILE      Output haplotype 2 reads to FILE (.gz supported)
  --output FILE, -o FILE
                        Output haplotype reads to FILE. Use this option as
                        many times as there are haplotypes in the input. The
                        first -o is used for H1, second for H2 etc.
  --output-untagged OUTPUT_UNTAGGED
                        Output file to write untagged reads to (.gz supported)
  --add-untagged        Add reads without tag to all (H1, H2, ...) outputs.
  --only-largest-block  Only consider reads to be tagged if they belong to the
                        largest phased block (in terms of read count) on their
                        respective chromosome
  --discard-unknown-reads
                        Only check the haplotype of reads listed in the
                        haplotag list file. Reads (read names) not contained
                        in this file will be discarded. In the default case (=
                        keep unknown reads), those reads would be considered
                        untagged and end up in the respective output file.
                        Please be sure that the read names match between the
                        input FASTQ/BAM and the haplotag list file.
  --read-lengths-histogram READ_LENGTHS_HISTOGRAM
                        Output file to write read lengths histogram to in tab-
                        separated format.
whatshap split: error: argument -h/--help: ignored explicit argument 'elp'
```


## whatshap_stats

### Tool Description
Print phasing statistics of a single VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap stats [-h] [--gtf FILE] [--block-list FILE] [--sample SAMPLE]
                      [--chr-lengths FILE] [--tsv FILE] [--only-snvs]
                      [--chromosome CHROMOSOME]
                      VCF

Print phasing statistics of a single VCF file

positional arguments:
  VCF                   Phased VCF file

optional arguments:
  -h, --help            show this help message and exit
  --gtf FILE            Write phased blocks as GTF with each block represented
                        as a 'gene'. If blocks are interleaved or nested, they
                        are split into multiple 'exons'.
  --block-list FILE     Write list of all blocks to FILE (one block per line).
                        Nested/interleaved blocks are not split.
  --sample SAMPLE       Name of the sample to process. If not given, use first
                        sample found in VCF.
  --chr-lengths FILE    Override chromosome lengths in VCF with those from
                        FILE (one line per chromosome, tab separated '<chr>
                        <length>'). Lengths are used to compute NG50 values.
  --tsv FILE            Write statistics in tab-separated value format to FILE
  --only-snvs           Only process SNVs and ignore all other variants.
  --chromosome CHROMOSOME
                        Name of chromosome(s) to process. If not given, all
                        chromosomes in the input VCF are considered. Can be
                        used multiple times and accepts a comma-separated
                        list.
whatshap stats: error: argument -h/--help: ignored explicit argument 'elp'
```


## whatshap_unphase

### Tool Description
Remove phasing information from a VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
- **Homepage**: https://whatshap.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/whatshap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: whatshap unphase [-h] VCF

Remove phasing information from a VCF file

This script removes all types of phasing information from the input VCF and
prints out the modified VCF to standard output. The modifications are:

- The HP, PS and PQ tags are removed
- Phasing in the GT tag (using pipe notation) is removed. The genotypes are
  sorted in ascending order. For example, a GT value of '1|0' is converted
  to '0/1'.

It is not an error if no phasing information was found.

positional arguments:
  VCF         VCF file. Use "-" to read from standard input

optional arguments:
  -h, --help  show this help message and exit
whatshap unphase: error: argument -h/--help: ignored explicit argument 'elp'
```


## Metadata
- **Skill**: generated
