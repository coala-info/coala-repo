cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - detect
label: dr-disco_detect
doc: "Detects and interprets intronic break points.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: bam_input_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output file
    inputBinding:
      position: 2
  - id: min_e_score
    type:
      - 'null'
      - int
    doc: Minimal score to initiate pulling sub-graphs (larger numbers boost 
      performance but result in suboptimal results)
    inputBinding:
      position: 102
      prefix: --min-e-score
outputs:
  - id: out_output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '$(inputs.output_file)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam_input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
