cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmerhmm
label: glimmerhmm
doc: "GlimmerHMM is a gene finding system based on a Generalized Hidden Markov Model
  (GHMM).\n\nTool homepage: https://github.com/kblin/glimmerhmm"
inputs:
  - id: genome_file
    type: File
    doc: Genome sequence file in FASTA format
    inputBinding:
      position: 1
  - id: training_dir
    type: Directory
    doc: Directory containing training data for the specific organism
    inputBinding:
      position: 2
  - id: acceptors_file
    type:
      - 'null'
      - File
    doc: Use a specific acceptors file
    inputBinding:
      position: 103
      prefix: -a
  - id: donors_file
    type:
      - 'null'
      - File
    doc: Use a specific donors file
    inputBinding:
      position: 103
      prefix: -d
  - id: gff_output
    type:
      - 'null'
      - boolean
    doc: Output in GFF format
    inputBinding:
      position: 103
      prefix: -g
  - id: protein_output
    type:
      - 'null'
      - boolean
    doc: Output protein sequences
    inputBinding:
      position: 103
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmerhmm:3.0.4--pl5321h503566f_10
