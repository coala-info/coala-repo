cwlVersion: v1.2
class: CommandLineTool
baseCommand: unfazed
label: unfazed
doc: "Identify de novo mutations (DNMs) in offspring using parental and offspring
  genotype and read data.\n\nTool homepage: https://github.com/jbelyeu/unfazed"
inputs:
  - id: ab_het
    type:
      - 'null'
      - string
    doc: allele balance range for heterozygous informative sites
    inputBinding:
      position: 101
      prefix: --ab-het
  - id: ab_homalt
    type:
      - 'null'
      - string
    doc: allele balance range for homozygous alternate informative sites
    inputBinding:
      position: 101
      prefix: --ab-homalt
  - id: ab_homref
    type:
      - 'null'
      - string
    doc: allele balance range for homozygous reference informative sites
    inputBinding:
      position: 101
      prefix: --ab-homref
  - id: bam_dir
    type:
      - 'null'
      - Directory
    doc: directory where bam/cram files (named {sample_id}.bam or 
      {sample_id}.cram) are stored for offspring. If not included, --bam-pairs 
      must be set
    inputBinding:
      position: 101
      prefix: --bam-dir
  - id: bam_pairs
    type:
      - 'null'
      - type: array
        items: string
    doc: space-delimited list of pairs in the format {sample_id}:{bam_path} 
      where {sample_id} matches an offspring id from the dnm file. Can be used 
      with --bam-dir arg, must be used in its absence
    inputBinding:
      position: 101
      prefix: --bam-pairs
  - id: build
    type:
      - 'null'
      - string
    doc: human genome build, used to determine sex chromosome pseudoautosomal 
      regions. If `na` option is chosen, sex chromosomes will not be 
      auto-phased. HG19/GRCh37 interchangeable
    inputBinding:
      position: 101
      prefix: --build
  - id: dnms
    type: File
    doc: valid VCF OR BED file of the DNMs of interest> If BED, must contain 
      chrom, start, end, kid_id, var_type columns
    inputBinding:
      position: 101
      prefix: --dnms
  - id: evidence_min_ratio
    type:
      - 'null'
      - float
    doc: minimum ratio of evidence for a parent to provide an unambiguous call. 
      Default 10:1
    inputBinding:
      position: 101
      prefix: --evidence-min-ratio
  - id: include_ambiguous
    type:
      - 'null'
      - boolean
    doc: include ambiguous phasing results
    inputBinding:
      position: 101
      prefix: --include-ambiguous
  - id: insert_size_max_sample
    type:
      - 'null'
      - int
    doc: maximum number of read inserts to sample in order to estimate 
      concordant read insert size
    inputBinding:
      position: 101
      prefix: --insert-size-max-sample
  - id: max_reads
    type:
      - 'null'
      - int
    doc: maximum number of reads to collect for phasing a single variant
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: min_depth
    type:
      - 'null'
      - int
    doc: min coverage for informative sites
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_gt_qual
    type:
      - 'null'
      - int
    doc: min genotype and base quality for informative sites
    inputBinding:
      position: 101
      prefix: --min-gt-qual
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: minimum map quality for reads
    inputBinding:
      position: 101
      prefix: --min-map-qual
  - id: multiread_proc_min
    type:
      - 'null'
      - int
    doc: min number of variants required to perform multiple parallel reads of 
      the sites file
    inputBinding:
      position: 101
      prefix: --multiread-proc-min
  - id: no_extended
    type:
      - 'null'
      - boolean
    doc: do not perform extended read-based phasing
    inputBinding:
      position: 101
      prefix: --no-extended
  - id: output_type
    type:
      - 'null'
      - string
    doc: choose output type. If --dnms is not a VCF/BCF, output must be to BED 
      format. Defaults to match --dnms input file
    inputBinding:
      position: 101
      prefix: --output-type
  - id: ped
    type: File
    doc: ped file including the kid and both parent IDs
    inputBinding:
      position: 101
      prefix: --ped
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: no logging of variant processing data
    inputBinding:
      position: 101
      prefix: --quiet
  - id: readlen
    type:
      - 'null'
      - int
    doc: expected length of input reads
    inputBinding:
      position: 101
      prefix: --readlen
  - id: reference
    type:
      - 'null'
      - File
    doc: reference fasta file (required for crams)
    inputBinding:
      position: 101
      prefix: --reference
  - id: search_dist
    type:
      - 'null'
      - int
    doc: maximum search distance from variant for informative sites (in bases)
    inputBinding:
      position: 101
      prefix: --search-dist
  - id: sites
    type: File
    doc: sorted/bgzipped/indexed VCF/BCF file of SNVs to identify informative 
      sites. Must contain each kid and both parents
    inputBinding:
      position: 101
      prefix: --sites
  - id: split_error_margin
    type:
      - 'null'
      - int
    doc: margin of error for the location of split read clipping in bases
    inputBinding:
      position: 101
      prefix: --split-error-margin
  - id: stdevs
    type:
      - 'null'
      - int
    doc: number of standard deviations from the mean insert length to define a 
      discordant read
    inputBinding:
      position: 101
      prefix: --stdevs
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output including sites and reads used for phasing. Only 
      applies to BED output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: name for output file. Defaults to stdout
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unfazed:1.0.2--pyh3252c3a_0
