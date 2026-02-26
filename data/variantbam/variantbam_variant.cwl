cwlVersion: v1.2
class: CommandLineTool
baseCommand: variant
label: variantbam_variant
doc: "Filter a BAM/SAM/CRAM/STDIN according to hierarchical rules\n\nTool homepage:
  https://github.com/jwalabroad/VariantBam"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM/SAM/CRAM/STDIN
    inputBinding:
      position: 1
  - id: exclude_aln_flag
    type:
      - 'null'
      - int
    doc: Flags to exclude (like samtools -F)
    inputBinding:
      position: 102
      prefix: --exclude-aln-flag
  - id: exclude_region
    type:
      - 'null'
      - type: array
        items: string
    doc: Same as -g, but for region where satisfying a rule EXCLUDES this read.
    inputBinding:
      position: 102
      prefix: --exclude-region
  - id: include_aln_flag
    type:
      - 'null'
      - int
    doc: Flags to include (like samtools -f)
    inputBinding:
      position: 102
      prefix: --include-aln-flag
  - id: linked_exclude_region
    type:
      - 'null'
      - type: array
        items: string
    doc: Same as -l, but for mate-linked region where satisfying this rule 
      EXCLUDES this read.
    inputBinding:
      position: 102
      prefix: --linked-exclude-region
  - id: linked_region
    type:
      - 'null'
      - type: array
        items: string
    doc: Same as -g, but turns on mate-linking
    inputBinding:
      position: 102
      prefix: --linked-region
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage of output file. BAM must be sorted. Negative values 
      enforce a minimum coverage
    inputBinding:
      position: 102
      prefix: --max-coverage
  - id: max_nbases
    type:
      - 'null'
      - int
    doc: Maximum number of N bases
    inputBinding:
      position: 102
      prefix: --max-nbases
  - id: min_clip
    type:
      - 'null'
      - int
    doc: Minimum number of quality clipped bases
    inputBinding:
      position: 102
      prefix: --min-clip
  - id: min_del
    type:
      - 'null'
      - int
    doc: Minimum number of deleted bases
    inputBinding:
      position: 102
      prefix: --min-del
  - id: min_ins
    type:
      - 'null'
      - int
    doc: Minimum number of inserted bases
    inputBinding:
      position: 102
      prefix: --min-ins
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length (after base-quality trimming)
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: min_phred
    type:
      - 'null'
      - int
    doc: Set the minimum base quality score considered to be high-quality
    inputBinding:
      position: 102
      prefix: --min-phred
  - id: motif
    type:
      - 'null'
      - File
    doc: Motif file
    inputBinding:
      position: 102
      prefix: --motif
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Don't output reads (used for profiling with -q)
    inputBinding:
      position: 102
      prefix: --no-output
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Output should be in binary BAM format
    inputBinding:
      position: 102
      prefix: --bam
  - id: output_cram
    type:
      - 'null'
      - boolean
    doc: Output file should be in CRAM format
    inputBinding:
      position: 102
      prefix: --cram
  - id: proc_regions_file
    type:
      - 'null'
      - string
    doc: Samtools-style region string (e.g. 1:1,000-2,000) or BED/VCF of regions
      to process. -k UN iterates over unmapped-unmapped reads
    inputBinding:
      position: 102
      prefix: --proc-regions-file
  - id: qc_file
    type:
      - 'null'
      - File
    doc: Output a qc file that contains information about BAM
    inputBinding:
      position: 102
      prefix: --qc-file
  - id: read_group
    type:
      - 'null'
      - string
    doc: Limit to just a single read group
    inputBinding:
      position: 102
      prefix: --read-group
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference. Required for reading/writing CRAM
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Regions (e.g. myvcf.vcf or WG for whole genome) or newline seperated 
      subsequence file.
    inputBinding:
      position: 102
      prefix: --region
  - id: region_pad
    type:
      - 'null'
      - int
    doc: Apply a padding to each region supplied with the region flags (specify 
      after region flag)
    inputBinding:
      position: 102
      prefix: --region-pad
  - id: rules
    type:
      - 'null'
      - string
    doc: JSON ecript for the rules.
    inputBinding:
      position: 102
      prefix: --rules
  - id: strip_all_tags
    type:
      - 'null'
      - boolean
    doc: Remove all alignment tags
    inputBinding:
      position: 102
      prefix: --strip-all-tags
  - id: strip_tags
    type:
      - 'null'
      - string
    doc: Remove the specified tags, separated by commas. eg. -s RG,MD
    inputBinding:
      position: 102
      prefix: --strip-tags
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_trimmed
    type:
      - 'null'
      - boolean
    doc: Output the base-quality trimmed sequence rather than the original 
      sequence. Also removes quality scores
    inputBinding:
      position: 102
      prefix: --write-trimmed
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write to (BAM/SAM/CRAM) file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantbam:1.4.3--0
