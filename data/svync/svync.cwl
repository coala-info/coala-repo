cwlVersion: v1.2
class: CommandLineTool
baseCommand: svync
label: svync
doc: "A tool to standardize VCF files from structural variant callers\n\nTool homepage:
  https://github.com/nvnieuwk/svync"
inputs:
  - id: config_file
    type: File
    doc: Configuration file (YAML) used for standardizing the VCF
    inputBinding:
      position: 101
      prefix: --config
  - id: input_file
    type: File
    doc: The input VCF file to standardize
    inputBinding:
      position: 101
      prefix: --input
  - id: mute_warnings
    type:
      - 'null'
      - boolean
    doc: Mute all warnings.
    default: false
    inputBinding:
      position: 101
      prefix: --mute-warnings
  - id: nodate
    type:
      - 'null'
      - boolean
    doc: Don't add the current date to the output VCF header
    default: false
    inputBinding:
      position: 101
      prefix: --nodate
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The location to the output VCF file, defaults to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svync:0.3.0--h9ee0642_0
