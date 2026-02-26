cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-actionstatemachine
label: camitk-actionstatemachine
doc: Build using CamiTK 4.1.2
inputs:
  - id: autonext
    type:
      - 'null'
      - boolean
    doc: Automatically run the state and the "Next" transition until final state
    inputBinding:
      position: 101
      prefix: --autonext
  - id: camitk_scxml_document
    type: File
    doc: CamiTK SCXML document to play back in the state machine
    inputBinding:
      position: 101
      prefix: --file
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory (will contains logs and saved files)
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-actionstatemachine:v4.1.2-3-deb_cv1
