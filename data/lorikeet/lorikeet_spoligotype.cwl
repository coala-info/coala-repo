cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - spoligotype
label: lorikeet_spoligotype
doc: "Spoligotype BAM file based on digital spoligotyping.\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs:
  - id: output_path
    type: string
    doc: File where you want the output to be written
    inputBinding:
      position: 1
      prefix: --output
  - id: spacer
    type:
      - 'null'
      - File
    doc: 'Optional: File containing spacers.'
    inputBinding:
      position: 2
      prefix: --spacer
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Optional: Show debug output.'
    inputBinding:
      position: 3
      prefix: --debug
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files. BAM, SAM, fastq and fastq.gz format are supported.
    inputBinding:
      position: 4
outputs:
  - id: output
    type: File
    doc: File where the output is written
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: JAVA_TOOL_OPTIONS
        envValue: -XX:-UseContainerSupport
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20--hdfd78af_1
