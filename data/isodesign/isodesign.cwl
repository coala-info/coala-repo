cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodesign
label: isodesign
doc: "A tool for designing DNA sequences with specific thermodynamic properties.\n\
  \nTool homepage: https://github.com/MetaboHUB-MetaToul-FluxoMet/IsoDesign"
inputs:
  - id: input_sequence
    type: string
    doc: The input DNA sequence.
    inputBinding:
      position: 1
  - id: salt_concentration
    type:
      - 'null'
      - float
    doc: The salt concentration in molar for thermodynamic calculations.
    default: 1.0
    inputBinding:
      position: 102
      prefix: --salt
  - id: temperature
    type:
      - 'null'
      - float
    doc: The temperature in Celsius for thermodynamic calculations.
    default: 37.0
    inputBinding:
      position: 102
      prefix: --temperature
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for results.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isodesign:2.0.3--pyhdfd78af_0
