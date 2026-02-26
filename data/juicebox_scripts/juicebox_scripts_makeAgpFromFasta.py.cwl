cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeAgpFromFasta.py
label: juicebox_scripts_makeAgpFromFasta.py
doc: "Converts a FASTA file to an AGP file.\n\nTool homepage: https://github.com/phasegenomics/juicebox_scripts"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: agp_out_file
    type: File
    doc: Output AGP file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
