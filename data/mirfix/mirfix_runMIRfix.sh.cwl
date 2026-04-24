cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirfix_runMIRfix.sh
label: mirfix_runMIRfix.sh
doc: "Running MIRfix with 1 cores, 10nt extension at --help\n\nTool homepage: https://github.com/Bierinformatik/MIRfix"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
  - id: extension_length
    type:
      - 'null'
      - int
    doc: extension length in nt
    inputBinding:
      position: 101
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Creating output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
