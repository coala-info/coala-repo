cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros
label: sipros
doc: "Sipros tool for processing MS2 or FT2 files.\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: configure file to be used
    inputBinding:
      position: 101
      prefix: -c
  - id: configuration_file_directory
    type:
      - 'null'
      - Directory
    doc: configure file directory
    inputBinding:
      position: 101
      prefix: -g
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: to set fasta file out of the configuration file
    inputBinding:
      position: 101
      prefix: -fasta
  - id: silence_output
    type:
      - 'null'
      - boolean
    doc: silence all standard output.
    inputBinding:
      position: 101
      prefix: -s
  - id: single_file
    type:
      - 'null'
      - File
    doc: a single MS2 or FT2 file to be processed
    inputBinding:
      position: 101
      prefix: -f
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: directory of MS2 or FT2 files to be processed
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
