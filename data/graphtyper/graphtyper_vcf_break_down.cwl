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
    doc: Path to graph.
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Path to VCF file to break down.
    inputBinding:
      position: 2
  - id: log
    type:
      - 'null'
      - File
    doc: Set path to log file.
    inputBinding:
      position: 103
      prefix: --log
  - id: region
    type:
      - 'null'
      - string
    doc: Region to print variant in.
    inputBinding:
      position: 103
      prefix: --region
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 103
      prefix: --vverbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output VCF file name.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
