cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popdel, profile]
label: popdel_profile
doc: "Write a profile of read pair distances for a given BAM or CRAM file. Iterates over (user defined regions of) a BAM or CRAM file in tiling windows of 256 bp.\n\nTool homepage: https://github.com/kehrlab/PopDel"
inputs:
  - id: reference
    type:
      - 'null'
      - string
    doc: "Reference genome version used for the mapping. Not used when using custom sampling intervals (option '-i'). One of 'GRCh37', 'GRCh38', 'hg19', 'hg38' (case-insensitive). Default: GRCh38."
    inputBinding:
      position: 1
      prefix: --reference
  - id: max_deletion_size
    type:
      - 'null'
      - int
    doc: "Maximum size of deletions. Default: 10000."
    inputBinding:
      position: 1
      prefix: --max-deletion-size
  - id: intervals
    type:
      - 'null'
      - File
    doc: "File with genomic intervals for parameter estimation instead of default intervals. One closed interval per line, formatted as 'CHROM:START-END', 1-based coordinates."
    inputBinding:
      position: 1
      prefix: --intervals
  - id: merge_read_groups
    type:
      - 'null'
      - boolean
    doc: "Merge all read groups of the sample. Only advised if they share the same properties!"
    inputBinding:
      position: 1
      prefix: --merge-read-groups
  - id: min_read_num
    type:
      - 'null'
      - int
    doc: "Minimum number of read pairs for parameter estimation (per read group). Default: 50000."
    inputBinding:
      position: 1
      prefix: --min-read-num
  - id: out_path
    type: string
    doc: "Output file name (profile file)."
    inputBinding:
      position: 1
      prefix: --out
  - id: flags_set
    type:
      - 'null'
      - int
    doc: "Only use reads with all bits of NUM set in the bam flag. Default: 33."
    inputBinding:
      position: 1
      prefix: --flags-set
  - id: flags_unset
    type:
      - 'null'
      - int
    doc: "Only use reads with all bits of NUM unset in the bam flag. Default: 3868."
    inputBinding:
      position: 1
      prefix: --flags-unset
  - id: index_region_size
    type:
      - 'null'
      - int
    doc: "Size of the index region intervals. Default: 10000."
    inputBinding:
      position: 1
      prefix: --index-region-size
  - id: min_mapping_qual
    type:
      - 'null'
      - int
    doc: "Only use reads with a mapping quality above NUM. Default: 1."
    inputBinding:
      position: 1
      prefix: --min-mapping-qual
  - id: reference_file
    type:
      - 'null'
      - File
    doc: "FASTA file of the reference genome. Only required for CRAM files whose header entries point to the wrong file."
    inputBinding:
      position: 1
      prefix: --reference-file
  - id: min_align_score
    type:
      - 'null'
      - float
    doc: "Only use reads with an alignment score relative to read length above NUM. Default: 0.8."
    inputBinding:
      position: 1
      prefix: --min-align-score
  - id: min_unclipped
    type:
      - 'null'
      - int
    doc: "Only use reads of which at least NUM bases are not clipped. Default: 50."
    inputBinding:
      position: 1
      prefix: --min-unclipped
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: "Don't use gzip compression for profile."
    inputBinding:
      position: 1
      prefix: --uncompressed
  - id: input_bam_cram_file
    type: File
    secondaryFiles:
      - ".bai"
    doc: "BAM/CRAM file (with index)"
    inputBinding:
      position: 100
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: "CHROM:BEGIN-END regions (optional)"
    inputBinding:
      position: 101
outputs:
  - id: profile
    type: File
    doc: "Profile file (gzipped binary)"
    outputBinding:
      glob: "$(inputs.out_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
