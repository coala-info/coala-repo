cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_collapse.py
label: gs-tama_tama_collapse.py
doc: "This script collapses mapped transcript models\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: capped_flag
    type:
      - 'null'
      - string
    doc: 'Capped flag: capped or no_cap'
    inputBinding:
      position: 101
      prefix: -x
  - id: collapse_exon_ends_flag
    type:
      - 'null'
      - string
    doc: 'Collapse exon ends flag: common_ends or longest_ends'
    inputBinding:
      position: 101
      prefix: -e
  - id: coverage
    type:
      - 'null'
      - int
    doc: Coverage
    inputBinding:
      position: 101
      prefix: -c
  - id: exon_splice_junction_threshold
    type:
      - 'null'
      - int
    doc: Exon/Splice junction threshold
    inputBinding:
      position: 101
      prefix: -m
  - id: genome_fasta_file
    type: File
    doc: Genome fasta file (required)
    inputBinding:
      position: 101
      prefix: -f
  - id: identity
    type:
      - 'null'
      - int
    doc: Identity
    inputBinding:
      position: 101
      prefix: -i
  - id: identity_calculation_method
    type:
      - 'null'
      - string
    doc: Identity calculation method (default ident_cov for including coverage) 
      (alternate is ident_map for excluding hard and soft clipping)
    inputBinding:
      position: 101
      prefix: -icm
  - id: local_density_error_threshold
    type:
      - 'null'
      - int
    doc: Threshold for amount of local density error near splice junctions that 
      is allowed
    inputBinding:
      position: 101
      prefix: -lde
  - id: merge_duplicate_transcript_groups_flag
    type:
      - 'null'
      - string
    doc: Flag for merging duplicate transcript groups (default is merge_dup will
      merge duplicates ,no_merge quits when duplicates are found)
      found
    inputBinding:
      position: 101
      prefix: -d
  - id: output_prefix
    type: string
    doc: Output prefix (required)
    inputBinding:
      position: 101
      prefix: -p
  - id: prime_3_threshold
    type:
      - 'null'
      - int
    doc: 3 prime threshold
    inputBinding:
      position: 101
      prefix: -z
  - id: prime_5_threshold
    type:
      - 'null'
      - int
    doc: 5 prime threshold
    inputBinding:
      position: 101
      prefix: -a
  - id: print_version
    type:
      - 'null'
      - boolean
    doc: Prints out version date and exits.
    inputBinding:
      position: 101
      prefix: -v
  - id: run_mode
    type:
      - 'null'
      - string
    doc: Run mode allows you to use original or low_mem mode, default is 
      original
    inputBinding:
      position: 101
      prefix: -rm
  - id: simple_error_symbol
    type:
      - 'null'
      - string
    doc: Simple error symbol. Use this to pick the symbol used to represent 
      matches in the simple error string for LDE output.
    inputBinding:
      position: 101
      prefix: -ses
  - id: sorted_sam_file
    type: File
    doc: Sorted sam file (required)
    inputBinding:
      position: 101
      prefix: -s
  - id: splice_junction_error_threshold
    type:
      - 'null'
      - int
    doc: Threshold for detecting errors near splice junctions
    inputBinding:
      position: 101
      prefix: -sjt
  - id: turn_off_log_output
    type:
      - 'null'
      - string
    doc: Turns off log output to screen of collapsing process.
    inputBinding:
      position: 101
      prefix: -log
  - id: use_bam
    type:
      - 'null'
      - boolean
    doc: Use BAM instead of SAM
    inputBinding:
      position: 101
      prefix: -b
  - id: use_splice_junction_priority
    type:
      - 'null'
      - string
    doc: Use error threshold to prioritize the use of splice junction 
      information from collapsing transcripts(default no_priority, activate with
      sj_priority)
    inputBinding:
      position: 101
      prefix: -sj
  - id: variation_coverage_threshold
    type:
      - 'null'
      - int
    doc: 'Variation coverage threshold: Default 5 reads'
    inputBinding:
      position: 101
      prefix: -vc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_collapse.py.out
