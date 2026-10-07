cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - aai
label: comparem_aai
doc: "Calculate the AAI between all genome pairs.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: query_gene_file
    type: File
    doc: "file with all query genes"
    inputBinding:
      position: 1
  - id: sorted_hit_table
    type: File
    doc: "sorted file indicating genes passing sequence similarity criteria"
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 3
  - id: evalue
    type:
      - 'null'
      - double
    doc: "maximum e-value for reporting an alignments (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --evalue
  - id: per_identity
    type:
      - 'null'
      - float
    doc: "minimum percent identity for reporting an alignment (default: 30.0)"
    inputBinding:
      position: 101
      prefix: --per_identity
  - id: per_aln_len
    type:
      - 'null'
      - float
    doc: "minimum percent coverage of query sequence for reporting an alignment (default: 70.0)"
    inputBinding:
      position: 101
      prefix: --per_aln_len
  - id: keep_rbhs
    type:
      - 'null'
      - boolean
    doc: "create file with reciprocal best hits"
    inputBinding:
      position: 101
      prefix: --keep_rbhs
  - id: cpus
    type:
      - 'null'
      - int
    doc: "number of CPUs to use (default: 1)"
    inputBinding:
      position: 101
      prefix: --cpus
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "suppress output"
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output_directory
    type: Directory
    doc: "output directory with aai_summary.tsv"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: aai_summary
    type: File
    doc: "AAI between all genome pairs"
    outputBinding:
      glob: $(inputs.output_dir)/aai_summary.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
