cwlVersion: v1.2
class: CommandLineTool
baseCommand: GSAlign
label: gsalign_GSAlign
doc: "GenAlign v1.0.22\n\nTool homepage: https://github.com/hsinnan75/GSAlign"
inputs:
  - id: query_file
    type: File
    doc: QueryFile[Fasta]
    inputBinding:
      position: 1
  - id: gnuplot_path
    type:
      - 'null'
      - string
    doc: Specify the path of gnuplot
    inputBinding:
      position: 102
      prefix: -gp
  - id: index_file_prefix
    type:
      - 'null'
      - string
    doc: IndexFile Prefix
    inputBinding:
      position: 102
  - id: max_indel_size
    type:
      - 'null'
      - int
    doc: Set the maximal indel size
    inputBinding:
      position: 102
      prefix: -ind
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Set the minimal alignment length
    inputBinding:
      position: 102
      prefix: -alen
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Set the minimal cluster size
    inputBinding:
      position: 102
      prefix: -clr
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: Set the minimal seed length
    inputBinding:
      position: 102
      prefix: -slen
  - id: min_sequence_identity
    type:
      - 'null'
      - int
    doc: Set the minimal sequence identity (0-100) of a local alignment
    inputBinding:
      position: 102
      prefix: -idy
  - id: one_on_one_alignment_mode
    type:
      - 'null'
      - boolean
    doc: set one on one aligment mode
    inputBinding:
      position: 102
      prefix: -one
  - id: output_dot_plots
    type:
      - 'null'
      - boolean
    doc: Output Dot-plots
    inputBinding:
      position: 102
      prefix: -dp
  - id: output_format
    type:
      - 'null'
      - int
    doc: Set the output format 1:maf, 2:aln
    inputBinding:
      position: 102
      prefix: -fmt
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Set the prefix of the output files
    inputBinding:
      position: 102
      prefix: -o
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference file
    inputBinding:
      position: 102
  - id: sensitive_mode
    type:
      - 'null'
      - boolean
    doc: Sensitive mode
    inputBinding:
      position: 102
      prefix: -sen
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: unique_alignment_only
    type:
      - 'null'
      - boolean
    doc: Output unique alignment only
    inputBinding:
      position: 102
      prefix: -unique
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsalign:1.0.22--hcb620b3_8
stdout: gsalign_GSAlign.out
