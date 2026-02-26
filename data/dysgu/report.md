# dysgu CWL Generation Report

## dysgu_call

### Tool Description
Call structural variants from bam alignment file/stdin

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Total Downloads**: 41.0K
- **Last updated**: 2025-09-27
- **GitHub**: https://github.com/kcleal/dysgu
- **Stars**: N/A
### Original Help Text
```text
Usage: dysgu call [OPTIONS] REFERENCE WORKING_DIRECTORY [SV_ALIGNS]

  Call structural variants from bam alignment file/stdin

Options:
  -b, --ibam PATH                 Original input file usef with 'fetch'
                                  command, used for calculating insert size
                                  parameters
  -o, --svs-out PATH              Output file [default: stdout]
  -f, --out-format [csv|vcf]      Output format  [default: vcf]
  --sites PATH                    A vcf file of known variant sites. Matching
                                  output variants are labelled with 'PASS'
                                  plus the ID from --sites
  --sites-prob FLOAT RANGE        Prior probability that a matching variant in
                                  --sites is true  [default: 0.6; 0<=x<=1]
  --sites-pass-only [True|False]  Only add variants from sites that have PASS
                                  [default: True]
  --ignore-sample-sites [True|False]
                                  If --sites is multi-sample, ignore variants
                                  from the input file SV-ALIGNS  [default:
                                  True]
  --parse-probs [True|False]      Parse INFO:MeanPROB or FORMAT:PROB instead
                                  of using --sites-p  [default: False]
  --all-sites [True|False]        Output a genotype for all variants in
                                  --sites (including homozygous reference 0/0)
  --pfix TEXT                     Post-fix of temp alignment file (used when a
                                  working-directory is provided instead of sv-
                                  aligns)
  --mode [pe|pacbio-sequel2|pacbio-revio|nanopore-r9|nanopore-r10|pacbio|nanopore]
                                  Type of input reads. Multiple options are
                                  set, overrides other options. | pacbio-
                                  sequel2: --mq 1 --paired False --min-support
                                  'auto' --max-cov 150 --dist-norm 600
                                  --trust-ins-len True --sd 0.45. | pacbio-
                                  revio: --mq 1 --paired False --min-support
                                  'auto' --max-cov 150 --dist-norm 600
                                  --trust-ins-len True --thresholds
                                  0.25,0.25,0.25,0.25,0.25 --sd 0.35. |
                                  nanopore-r9: --mq 1 --paired False --min-
                                  support 'auto' --max-cov 150 --dist-norm 900
                                  --trust-ins-len False --sd 0.6 --divergence
                                  auto. | nanopore-r10: --mq 1 --paired False
                                  --min-support 'auto' --max-cov 150 --dist-
                                  norm 600 --trust-ins-len False --thresholds
                                  0.35,0.35,0.35,0.35,0.35 --sd 0.35
                                  [default: pe]
  --pl [pe|pacbio|nanopore]       Type of input reads  [default: pe]
  --clip-length INTEGER           Minimum soft-clip length, >= threshold are
                                  kept. Set to -1 to ignore [default:
                                  {deafults['clip_length']}]
  --max-cov TEXT                  Regions with > max-cov that do no overlap
                                  'include' are discarded. Use 'auto' to
                                  estimate a value from the alignment index
                                  file [default: 200]. Regions with > max-cov
                                  that do no overlap 'include' are discarded.
                                  Set to -1 to ignore.
  --max-tlen INTEGER              Maximum template length to consider when
                                  calculating paired-end template size
                                  [default: 1000]
  --min-support TEXT              Minimum number of reads per SV  [default: 3]
  --min-size INTEGER              Minimum size of SV to report  [default: 30]
  --mq INTEGER                    Minimum map quality < threshold are
                                  discarded  [default: 1]
  --dist-norm FLOAT               Distance normalizer  [default: 100]
  --spd FLOAT                     Span position distance [defaults: 0.3]
  --sd FLOAT                      Span distance, only SV span is considered,
                                  lower values separate multi-allelic sites
                                  [default=0.8
  --search-depth FLOAT            Search through this many local reads for
                                  matching SVs. Increase this to identify low
                                  frequency events  [default: 20]
  --trust-ins-len TEXT            Trust insertion length from cigar, for high
                                  error rate reads use False  [default: True]
  --length-extend INTEGER         Extend SV length if any nearby gaps found
                                  with length >= length-extend. Ignored for
                                  paired-end reads  [default: 15]
  --divergence TEXT               Threshold used for ignoring divergent ends
                                  of alignments. Ignored for paired-end reads.
                                  Use 'auto' to try to infer for noisy reads
                                  [default: 0.02]
  -I, --template-size TEXT        Manually set insert size, insert stdev,
                                  read_length as 'INT,INT,INT'
  --regions PATH                  bed file of target regions, used for
                                  labelling events
  --regions-only [True|False]     If --regions is provided, call only events
                                  within target regions  [default: False]
  --regions-mm-only [True|False]  If --regions is provided, only use minimizer
                                  clustering within --regions. Useful for high
                                  coverage targeted sequencing  [default:
                                  False]
  -p, --procs INTEGER RANGE       Processors to use  [default: 1; 1<=x<=20]
  --buffer-size INTEGER           Number of alignments to buffer  [default: 0]
  --merge-within [True|False]     Try and merge similar events, recommended
                                  for most situations  [default: True]
  --drop-gaps [True|False]        Drop SVs near gaps +/- 250 bp of Ns in
                                  reference  [default: True]
  --merge-dist INTEGER            Attempt merging of SVs below this distance
                                  threshold, default is (insert-median +
                                  5*insert_std) for pairedreads, or 2000 bp
                                  for single-end reads
  --paired [True|False]           Paired-end reads or single  [default: True]
  --contigs [True|False]          Generate consensus contigs for each side of
                                  break and use sequence-based metrics in
                                  model scoring  [default: True]
  -v, --verbosity [0|1|2]         0 = no contigs in output, 1 = output contigs
                                  for variants without ALT sequence called, 2
                                  = output all contigs  [default: 1]
  --diploid [True|False]          Use diploid model for scoring variants. Use
                                  'False' for non-diploid or poly clonal
                                  samples  [default: True]
  --remap TEXT                    Try and remap anomalous contigs to find
                                  additional small SVs  [default: True]
  --no-phase                      Do not use HP haplotagged reads to phase
                                  variants
  --metrics                       Output additional metrics for each SV
  --keep-small                    Keep SVs < min-size found during re-mapping
  --symbolic-sv-size INTEGER      Use symbolic representation if SV >= this
                                  size. Set to -1 to use symbolic-only
                                  representation [default=50000]
  --low-mem                       Use less memory but more temp disk space
  -x, --overwrite                 Overwrite temp files
  -c, --clean                     Remove temp files and working directory when
                                  finished
  --thresholds TEXT               Probability threshold to label as PASS for
                                  'DEL,INS,INV,DUP,TRA' [default:
                                  0.45,0.45,0.45,0.45,0.45
  --help                          Show this message and exit.
```


## dysgu_fetch

### Tool Description
Filters input bam/cram for read-pairs that are discordant or have a soft-clip of length > '--clip-length', saves bam file in WORKING_DIRECTORY

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dysgu fetch [OPTIONS] WORKING_DIRECTORY BAM

  Filters input bam/cram for read-pairs that are discordant or have a soft-
  clip of length > '--clip-length', saves bam file in WORKING_DIRECTORY

Options:
  --reference PATH           Reference file for opening cram files
  --pfix TEXT                Post-fix to add to temp alignment files
  -o, --output PATH          Output reads, discordant, supplementary and soft-
                             clipped reads to file.
  --compression TEXT         Set output bam compression level. Default is
                             uncompressed  [default: wb0]
  -a, --write_all            Write all alignments from SV-read template to
                             temp file
  --clip-length INTEGER      Minimum soft-clip length, >= threshold are kept.
                             Set to -1 to ignore  [default: 15]
  --mq INTEGER               Minimum map quality < threshold are discarded
                             [default: 1]
  --min-size INTEGER         Minimum size of SV to report  [default: 30]
  --max-cov FLOAT            Genomic regions with coverage > max-cov are
                             discarded. Set to -1 to ignore.  [default: 200]
  -p, --procs INTEGER RANGE  Compression threads to use for writing bam
                             [default: 1; 1<=x<=20]
  --search PATH              .bed file, limit search to regions
  --exclude PATH             .bed file, do not search/call SVs within regions.
                             Takes precedence over --search
  -x, --overwrite            Overwrite temp files
  --pl [pe|pacbio|nanopore]  Type of input reads  [default: pe]
  --help                     Show this message and exit.
```


## dysgu_filter

### Tool Description
Filter a vcf generated by dysgu. Unique SVs can be found in the input_vcf by supplying a --normal-vcf (single or multi-sample), and normal bam files. Bam/vcf samples with the same name as the input_vcf will be ignored

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dysgu filter [OPTIONS] INPUT_VCF [NORMAL_BAMS]...

  Filter a vcf generated by dysgu. Unique SVs can be found in the input_vcf by
  supplying a --normal-vcf (single or multi-sample), and normal bam files.
  Bam/vcf samples with the same name as the input_vcf will be ignored

Options:
  --reference PATH              Reference for cram input files
  -o, --svs-out PATH            Output file, [default: stdout]
  -n, --normal-vcf PATH         Vcf file for normal sample, or panel of
                                normals. The SM tag of input bams is used to
                                ignore the input_vcf for multi-sample vcfs
  -p, --procs INTEGER RANGE     Reading threads for normal_bams  [default: 1;
                                1<=x<=20]
  -f, --support-fraction FLOAT  Minimum threshold support fraction / coverage
                                (SU/COV)  [default: 0.1]
  --target-sample TEXT          If input_vcf if multi-sample, use target-
                                sample as input
  --keep-all                    All SVs classified as normal will be kept in
                                the output, labelled as filter=normal
  --ignore-read-groups          Ignore ReadGroup RG tags when parsing sample
                                names. Filenames will be used instead
  --max-divergence FLOAT        Remove SV if normal_bam displays divergence >
                                max-divergence at same location  [default:
                                0.1]
  --min-prob FLOAT              Remove SV with PROB value < min-prob
                                [default: 0.1]
  --min-mapq FLOAT              Remove SV with mean mapqq < min-mapq
                                [default: 10]
  --pass-prob FLOAT             Re-label SV as PASS if PROB value >= pass-prob
                                [default: 1.0]
  --interval-size INTEGER       Interval size for searching normal-vcf/normal-
                                bams  [default: 1000]
  --random-bam-sample INTEGER   Choose N random normal-bams to search. Use -1
                                to ignore  [default: -1]
  --help                        Show this message and exit.
```


## dysgu_merge

### Tool Description
Merge vcf/csv variant files

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dysgu merge [OPTIONS] [INPUT_FILES]...

  Merge vcf/csv variant files

Options:
  -i, --input-list PATH           Input list of file paths, one line per file
  -o, --svs-out PATH              Output file, [default: stdout]
  -f, --out-format [csv|vcf]      Output format  [default: vcf]
  -p, --procs INTEGER RANGE       Number of processors to use when merging,
                                  requires --wd option to be supplied
                                  [default: 1; 1<=x<=20]
  -d, --wd PATH                   Working directory to use/create when merging
  -c, --clean                     Remove working directory when finished
  --progress                      Prints detailed progress information
  --cohort-update PATH            Updated this cohort file with new calls from
                                  input_files
  --collapse-nearby [True|False]  Merges more aggressively by collapsing
                                  nearby SV  [default: True]
  --merge-across [True|False]     Merge records across input samples
                                  [default: True]
  --merge-method [auto|all-vs-all|progressive]
                                  Method of merging using --merge-across.
                                  Progressive is suitable for large cohorts.
                                  Auto will switch to progressive for >4
                                  samples  [default: auto]
  --merge-within [True|False]     Perform additional merge within input
                                  samples, prior to --merge-across  [default:
                                  False]
  --merge-dist INTEGER            Distance threshold for merging  [default:
                                  500]
  --max-comparisons INTEGER       Compare each event with up to --max-
                                  comparisons local SVs  [default: 20]
  --separate [True|False]         Keep merged tables separate, adds --post-fix
                                  to file names, csv format only  [default:
                                  False]
  --post-fix TEXT                 Adds --post-fix to file names, only if
                                  --separate is True  [default: dysgu]
  --add-kind [True|False]         Add region-overlap 'kind' to vcf output
                                  [default: False]
  -v, --verbosity [0|1|2]         0 = no contigs in output, 1 = output contigs
                                  for variants without ALT sequence called, 2
                                  = output all contigs  [default: 1]
  --help                          Show this message and exit.
```


## dysgu_run

### Tool Description
Run the dysgu pipeline. Important parameters are --mode, --diploid, --min-support, --min-size, --max-cov

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dysgu run [OPTIONS] REFERENCE WORKING_DIRECTORY BAM

  Run the dysgu pipeline. Important parameters are --mode, --diploid, --min-
  support, --min-size, --max-cov

Options:
  --sites PATH                    A vcf file of known variant sites. All sites
                                  will be genotyped in the output vcf
  --sites-prob FLOAT RANGE        Prior probability that a matching variant in
                                  --sites is true  [default: 0.6; 0<=x<=1]
  --sites-pass-only [True|False]  Only add variants from sites that have PASS
                                  [default: True]
  --ignore-sample-sites [True|False]
                                  If --sites is multi-sample, ignore variants
                                  from the input file SV-ALIGNS  [default:
                                  True]
  --parse-probs [True|False]      Parse INFO:MeanPROB or FORMAT:PROB instead
                                  of using --sites-p  [default: False]
  --all-sites [True|False]        Output a genotype for all variants in
                                  --sites (including homozygous reference 0/0)
  --pfix TEXT                     Post-fix to add to temp alignment files
  -o, --svs-out PATH              Output file, [default: stdout]
  -f, --out-format [csv|vcf]      Output format  [default: vcf]
  -a, --write_all                 Write all alignments from SV-read template
                                  to temp file
  --compression TEXT              Set temp file bam compression level. Default
                                  is uncompressed  [default: wb0]
  -p, --procs INTEGER RANGE       Number of cpu cores to use  [default: 1;
                                  1<=x<=20]
  --mode [pe|pacbio-sequel2|pacbio-revio|nanopore-r9|nanopore-r10|pacbio|nanopore]
                                  Type of input reads. Multiple options are
                                  set, overrides other options. | pacbio-
                                  sequel2: --mq 1 --paired False --min-support
                                  'auto' --max-cov 150 --dist-norm 600
                                  --trust-ins-len True --sd 0.45 --compression
                                  wb3. | pacbio-revio: --mq 1 --paired False
                                  --min-support 'auto' --max-cov 150 --dist-
                                  norm 600 --trust-ins-len True --thresholds
                                  0.25,0.25,0.25,0.25,0.25 --sd 0.35
                                  --compression wb3. | nanopore-r9: --mq 1
                                  --paired False --min-support 'auto' --max-
                                  cov 150 --dist-norm 900 --trust-ins-len
                                  False --sd 0.6 --divergence auto
                                  --compression wb3. | nanopore-r10: --mq 1
                                  --paired False --min-support 'auto' --max-
                                  cov 150 --dist-norm 600 --trust-ins-len
                                  False --thresholds 0.35,0.35,0.35,0.35,0.35
                                  --sd 0.35 --compression wb3  [default: pe]
  --pl [pe|pacbio|nanopore]       Type of input reads  [default: pe]
  --clip-length INTEGER           Minimum soft-clip length, >= threshold are
                                  kept. Set to -1 to ignore [default:
                                  {deafults['clip_length']}]
  --max-cov TEXT                  Genomic regions with coverage > max-cov
                                  discarded. Use 'auto' to estimate a value
                                  from the alignment index file [default:
                                  200]. Set to -1 to ignore
  --max-tlen INTEGER              Maximum template length to consider when
                                  calculating paired-end template size
                                  [default: 1000]
  --min-support TEXT              Minimum number of reads per SV  [default: 3]
  --min-size INTEGER              Minimum size of SV to report  [default: 30]
  --mq INTEGER                    Minimum map quality < threshold are
                                  discarded  [default: 1]
  --dist-norm FLOAT               Distance normalizer  [default: 100]
  --spd FLOAT                     Span position distance [defaults: 0.3]
  --sd FLOAT                      Span distance, only SV span is considered,
                                  lower values separate multi-allelic sites
                                  [default=0.8
  --search-depth FLOAT            Search through this many local reads for
                                  matching SVs. Increase this to identify low
                                  frequency events  [default: 20]
  --trust-ins-len TEXT            Trust insertion length from cigar, for high
                                  error rate reads use False  [default: True]
  --length-extend INTEGER         Extend SV length if any nearby gaps found
                                  with length >= length-extend. Ignored for
                                  paired-end reads  [default: 15]
  --divergence TEXT               Threshold used for ignoring divergent ends
                                  of alignments. Ignored for paired-end reads.
                                  Use 'auto' to try to infer for noisy reads
                                  [default: 0.02]
  -I, --template-size TEXT        Manually set insert size, insert stdev,
                                  read_length as 'INT,INT,INT'
  --search PATH                   .bed file, limit search to regions
  --exclude PATH                  .bed file, do not search/call SVs within
                                  regions. Takes precedence over --search
  --regions PATH                  bed file of target regions, used for
                                  labelling events
  --regions-mm-only [True|False]  If --regions is provided, only use minimizer
                                  clustering within --regions. Useful for high
                                  coverage targeted sequencing  [default:
                                  False]
  --buffer-size INTEGER           Number of alignments to buffer  [default: 0]
  --merge-within [True|False]     Try and merge similar events, recommended
                                  for most situations  [default: True]
  --drop-gaps [True|False]        Drop SVs near gaps +/- 250 bp of Ns in
                                  reference  [default: True]
  --merge-dist INTEGER            Attempt merging of SVs below this distance
                                  threshold. Default for paired-end data is
                                  (insert-median + 5*insert_std) for paired
                                  reads, or 2000 bp for single-end reads
  --paired [True|False]           Paired-end reads or single  [default: True]
  --contigs [True|False]          Generate consensus contigs for each side of
                                  break and use sequence-based metrics in
                                  model scoring  [default: True]
  -v, --verbosity [0|1|2]         0 = no contigs in output, 1 = output contigs
                                  for variants without ALT sequence called, 2
                                  = output all contigs  [default: 1]
  --diploid [True|False]          Use diploid model for scoring variants. Use
                                  'False' for non-diploid or poly clonal
                                  samples  [default: True]
  --remap TEXT                    Try and remap anomalous contigs to find
                                  additional small SVs  [default: True]
  --no-phase                      Do not use HP haplotagged reads to phase
                                  variants
  --metrics                       Output additional metrics for each SV
  --keep-small                    Keep SVs < min-size found during re-mapping
  --symbolic-sv-size INTEGER      Use symbolic representation if SV >= this
                                  size. Set to -1 to use symbolic-only
                                  representation [default=50000]
  --low-mem                       Use less memory but more temp disk space
  -x, --overwrite                 Overwrite temp files
  -c, --clean                     Remove temp files and working directory when
                                  finished
  --thresholds TEXT               Probability threshold to label as PASS for
                                  'DEL,INS,INV,DUP,TRA' [default:
                                  0.45,0.45,0.45,0.45,0.45
  --help                          Show this message and exit.
```


## dysgu_test

### Tool Description
Run dysgu tests

### Metadata
- **Docker Image**: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
- **Homepage**: https://github.com/kcleal/dysgu
- **Package**: https://anaconda.org/channels/bioconda/packages/dysgu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dysgu test [OPTIONS]

  Run dysgu tests

Options:
  --verbose  Show output of test commands
  --help     Show this message and exit.
```

