cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyrcular plot
label: cyrcular_plot
doc: "Generates a circular plot from BAM data.\n\nTool homepage: https://github.com/tedil/cyrcular"
inputs:
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bin_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --bin-size
  - id: breakpoint_margin
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --breakpoint-margin
  - id: flank
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --flank
  - id: region
    type: string
    inputBinding:
      position: 102
      prefix: --region
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyrcular:0.3.0--ha8ac579_1
