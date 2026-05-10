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
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Creating output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
