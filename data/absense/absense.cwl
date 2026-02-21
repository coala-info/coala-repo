cwlVersion: v1.2
class: CommandLineTool
baseCommand: absense
label: absense
doc: "A tool for detecting gene absence in genome assemblies using a reference-based
  approach.\n\nTool homepage: https://github.com/caraweisman/abSENSE"
inputs:
  - id: database
    type: File
    doc: Blast database or genome assembly file
    inputBinding:
      position: 101
      prefix: --database
  - id: e_value
    type:
      - 'null'
      - float
    doc: E-value threshold for BLAST searches
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: query_genes
    type: File
    doc: Fasta file containing query gene sequences
    inputBinding:
      position: 101
      prefix: --query
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BLAST searches
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
