cwlVersion: v1.2
class: CommandLineTool
baseCommand: pylprotpredictor
label: pylprotpredictor
doc: "PylProtPredictor Pipeline\n\nTool homepage: http://bebatut.fr/PylProtPredictor/"
inputs:
  - id: genome
    type: File
    doc: path to a FASTA file with full or contig sequences of a genome to 
      analyze
    inputBinding:
      position: 101
      prefix: --genome
  - id: reference_dmnd_db
    type:
      - 'null'
      - File
    doc: path to Diamond formatted file with reference database
    inputBinding:
      position: 101
      prefix: --reference_dmnd_db
  - id: reference_fasta_db
    type:
      - 'null'
      - File
    doc: path to FASTA file with reference database
    inputBinding:
      position: 101
      prefix: --reference_fasta_db
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylprotpredictor:1.0.2--py_0
