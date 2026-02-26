cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dysgu
  - run
label: dysgu_run
doc: "Run the dysgu pipeline. Important parameters are --mode, --diploid, --min-support,
  --min-size, --max-cov\n\nTool homepage: https://github.com/kcleal/dysgu"
inputs:
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 1
  - id: working_directory
    type: Directory
    doc: Working directory for temporary files
    inputBinding:
      position: 2
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 3
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: Output a genotype for all variants in --sites (including homozygous 
      reference 0/0)
    inputBinding:
      position: 104
      prefix: --all-sites
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Number of alignments to buffer
    default: 0
    inputBinding:
      position: 104
      prefix: --buffer-size
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove temp files and working directory when finished
    inputBinding:
      position: 104
      prefix: --clean
  - id: clip_length
    type:
      - 'null'
      - int
    doc: Minimum soft-clip length, >= threshold are kept. Set to -1 to ignore
    inputBinding:
      position: 104
      prefix: --clip-length
  - id: compression
    type:
      - 'null'
      - string
    doc: Set temp file bam compression level. Default is uncompressed
    default: wb0
    inputBinding:
      position: 104
      prefix: --compression
  - id: contigs
    type:
      - 'null'
      - boolean
    doc: Generate consensus contigs for each side of break and use 
      sequence-based metrics in model scoring
    default: true
    inputBinding:
      position: 104
      prefix: --contigs
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: Use diploid model for scoring variants. Use 'False' for non-diploid or 
      poly clonal samples
    default: true
    inputBinding:
      position: 104
      prefix: --diploid
  - id: dist_norm
    type:
      - 'null'
      - float
    doc: Distance normalizer
    default: 100.0
    inputBinding:
      position: 104
      prefix: --dist-norm
  - id: divergence
    type:
      - 'null'
      - string
    doc: Threshold used for ignoring divergent ends of alignments. Ignored for 
      paired-end reads. Use 'auto' to try to infer for noisy reads
    default: '0.02'
    inputBinding:
      position: 104
      prefix: --divergence
  - id: drop_gaps
    type:
      - 'null'
      - boolean
    doc: Drop SVs near gaps +/- 250 bp of Ns in reference
    default: true
    inputBinding:
      position: 104
      prefix: --drop-gaps
  - id: exclude
    type:
      - 'null'
      - File
    doc: .bed file, do not search/call SVs within regions. Takes precedence over
      --search
    inputBinding:
      position: 104
      prefix: --exclude
  - id: ignore_sample_sites
    type:
      - 'null'
      - boolean
    doc: If --sites is multi-sample, ignore variants from the input file 
      SV-ALIGNS
    default: true
    inputBinding:
      position: 104
      prefix: --ignore-sample-sites
  - id: keep_small
    type:
      - 'null'
      - boolean
    doc: Keep SVs < min-size found during re-mapping
    inputBinding:
      position: 104
      prefix: --keep-small
  - id: length_extend
    type:
      - 'null'
      - int
    doc: Extend SV length if any nearby gaps found with length >= length-extend.
      Ignored for paired-end reads
    default: 15
    inputBinding:
      position: 104
      prefix: --length-extend
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Use less memory but more temp disk space
    inputBinding:
      position: 104
      prefix: --low-mem
  - id: max_cov
    type:
      - 'null'
      - string
    doc: Genomic regions with coverage > max-cov discarded. Use 'auto' to 
      estimate a value from the alignment index file. Set to -1 to ignore
    default: '200'
    inputBinding:
      position: 104
      prefix: --max-cov
  - id: max_tlen
    type:
      - 'null'
      - int
    doc: Maximum template length to consider when calculating paired-end 
      template size
    default: 1000
    inputBinding:
      position: 104
      prefix: --max-tlen
  - id: merge_dist
    type:
      - 'null'
      - int
    doc: Attempt merging of SVs below this distance threshold. Default for 
      paired-end data is (insert-median + 5*insert_std) for paired reads, or 
      2000 bp for single-end reads
    inputBinding:
      position: 104
      prefix: --merge-dist
  - id: merge_within
    type:
      - 'null'
      - boolean
    doc: Try and merge similar events, recommended for most situations
    default: true
    inputBinding:
      position: 104
      prefix: --merge-within
  - id: metrics
    type:
      - 'null'
      - boolean
    doc: Output additional metrics for each SV
    inputBinding:
      position: 104
      prefix: --metrics
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of SV to report
    default: 30
    inputBinding:
      position: 104
      prefix: --min-size
  - id: min_support
    type:
      - 'null'
      - string
    doc: Minimum number of reads per SV
    default: '3'
    inputBinding:
      position: 104
      prefix: --min-support
  - id: mode
    type:
      - 'null'
      - string
    doc: "Type of input reads. Multiple options are set, overrides other options.
      | pacbio-sequel2: --mq 1 --paired False --min-support 'auto' --max-cov 150 --dist-norm
      600 --trust-ins-len True --sd 0.45 --compression wb3. | pacbio-revio: --mq 1
      --paired False --min-support 'auto' --max-cov 150 --dist-norm 600 --trust-ins-len
      True --thresholds 0.25,0.25,0.25,0.25,0.25 --sd 0.35 --compression wb3. | nanopore-r9:
      --mq 1 --paired False --min-support 'auto' --max-cov 150 --dist-norm 900 --trust-ins-len
      False --sd 0.6 --divergence auto --compression wb3. | nanopore-r10: --mq 1 --paired
      False --min-support 'auto' --max-cov 150 --dist-norm 600 --trust-ins-len False
      --thresholds 0.35,0.35,0.35,0.35,0.35 --sd 0.35 --compression wb3"
    default: pe
    inputBinding:
      position: 104
      prefix: --mode
  - id: mq
    type:
      - 'null'
      - int
    doc: Minimum map quality < threshold are discarded
    default: 1
    inputBinding:
      position: 104
      prefix: --mq
  - id: no_phase
    type:
      - 'null'
      - boolean
    doc: Do not use HP haplotagged reads to phase variants
    inputBinding:
      position: 104
      prefix: --no-phase
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format
    default: vcf
    inputBinding:
      position: 104
      prefix: --out-format
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite temp files
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Paired-end reads or single
    default: true
    inputBinding:
      position: 104
      prefix: --paired
  - id: parse_probs
    type:
      - 'null'
      - boolean
    doc: Parse INFO:MeanPROB or FORMAT:PROB instead of using --sites-p
    default: false
    inputBinding:
      position: 104
      prefix: --parse-probs
  - id: pfix
    type:
      - 'null'
      - string
    doc: Post-fix to add to temp alignment files
    inputBinding:
      position: 104
      prefix: --pfix
  - id: pl
    type:
      - 'null'
      - string
    doc: Type of input reads
    default: pe
    inputBinding:
      position: 104
      prefix: --pl
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of cpu cores to use
    default: 1
    inputBinding:
      position: 104
      prefix: --procs
  - id: regions
    type:
      - 'null'
      - File
    doc: bed file of target regions, used for labelling events
    inputBinding:
      position: 104
      prefix: --regions
  - id: regions_mm_only
    type:
      - 'null'
      - boolean
    doc: If --regions is provided, only use minimizer clustering within 
      --regions. Useful for high coverage targeted sequencing
    default: false
    inputBinding:
      position: 104
      prefix: --regions-mm-only
  - id: remap
    type:
      - 'null'
      - string
    doc: Try and remap anomalous contigs to find additional small SVs
    default: 'True'
    inputBinding:
      position: 104
      prefix: --remap
  - id: sd
    type:
      - 'null'
      - float
    doc: Span distance, only SV span is considered, lower values separate 
      multi-allelic sites
    default: 0.8
    inputBinding:
      position: 104
      prefix: --sd
  - id: search
    type:
      - 'null'
      - File
    doc: .bed file, limit search to regions
    inputBinding:
      position: 104
      prefix: --search
  - id: search_depth
    type:
      - 'null'
      - float
    doc: Search through this many local reads for matching SVs. Increase this to
      identify low frequency events
    default: 20.0
    inputBinding:
      position: 104
      prefix: --search-depth
  - id: sites
    type:
      - 'null'
      - File
    doc: A vcf file of known variant sites. All sites will be genotyped in the 
      output vcf
    inputBinding:
      position: 104
      prefix: --sites
  - id: sites_pass_only
    type:
      - 'null'
      - boolean
    doc: Only add variants from sites that have PASS
    default: true
    inputBinding:
      position: 104
      prefix: --sites-pass-only
  - id: sites_prob
    type:
      - 'null'
      - float
    doc: Prior probability that a matching variant in --sites is true
    default: 0.6
    inputBinding:
      position: 104
      prefix: --sites-prob
  - id: spd
    type:
      - 'null'
      - float
    doc: Span position distance
    default: 0.3
    inputBinding:
      position: 104
      prefix: --spd
  - id: symbolic_sv_size
    type:
      - 'null'
      - int
    doc: Use symbolic representation if SV >= this size. Set to -1 to use 
      symbolic-only representation
    default: 50000
    inputBinding:
      position: 104
      prefix: --symbolic-sv-size
  - id: template_size
    type:
      - 'null'
      - string
    doc: Manually set insert size, insert stdev, read_length as 'INT,INT,INT'
    inputBinding:
      position: 104
      prefix: --template-size
  - id: thresholds
    type:
      - 'null'
      - string
    doc: Probability threshold to label as PASS for 'DEL,INS,INV,DUP,TRA'
    default: 0.45,0.45,0.45,0.45,0.45
    inputBinding:
      position: 104
      prefix: --thresholds
  - id: trust_ins_len
    type:
      - 'null'
      - string
    doc: Trust insertion length from cigar, for high error rate reads use False
    default: 'True'
    inputBinding:
      position: 104
      prefix: --trust-ins-len
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 0 = no contigs in output, 1 = output contigs for variants without ALT 
      sequence called, 2 = output all contigs
    default: 1
    inputBinding:
      position: 104
      prefix: --verbosity
  - id: write_all
    type:
      - 'null'
      - boolean
    doc: Write all alignments from SV-read template to temp file
    inputBinding:
      position: 104
      prefix: --write_all
outputs:
  - id: svs_out
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.svs_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
