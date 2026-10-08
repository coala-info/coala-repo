cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - vcf_break_down
label: graphtyper_vcf_break_down
doc: "Break down/decompose a VCF file.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: graph
    type: File
    doc: "Path to graph."
    inputBinding:
      position: 1
  - id: vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Path to VCF file to break down."
    inputBinding:
      position: 2
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: output
    type:
      - 'null'
      - string
    doc: "Output VCF file name (default -, standard output)."
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: region
    type:
      - 'null'
      - string
    doc: "Region to print variant in."
    inputBinding:
      position: 10
      prefix: "--region="
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_vcf_break_down.out
