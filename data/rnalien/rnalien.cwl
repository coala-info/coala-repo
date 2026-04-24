cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAlien
label: rnalien
doc: "RNAlien is a tool for the construction of RNA family models. It automatically
  collects sequences, performs structural alignments, and creates covariance models.\n
  \nTool homepage: http://rna.tbi.univie.ac.at/rnalien/tool"
inputs:
  - id: blast_database
    type:
      - 'null'
      - string
    doc: Path to the blast database
    inputBinding:
      position: 101
      prefix: -d
  - id: cpu_threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    inputBinding:
      position: 101
      prefix: -c
  - id: e_value_cutoff
    type:
      - 'null'
      - float
    doc: E-value cutoff for homology search
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type: File
    doc: Input fasta file containing the query sequence(s)
    inputBinding:
      position: 101
      prefix: -i
  - id: tax_scope
    type:
      - 'null'
      - int
    doc: NCBI taxonomy ID to limit the search scope
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the results will be stored
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalien:1.8.0--1
