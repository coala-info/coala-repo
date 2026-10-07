cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - seg
label: cnvkit_export_seg
doc: "Convert segments to SEG format. Compatible with IGV and GenePattern.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: "Segmented copy ratio data file(s) (*.cns), the output of the 'segment' sub-command."
    inputBinding:
      position: 1
  - id: enumerate_chroms
    type:
      - 'null'
      - boolean
    doc: "Replace chromosome names with sequential integer IDs."
    inputBinding:
      position: 101
      prefix: --enumerate-chroms
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
