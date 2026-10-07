cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - breaks
label: cnvkit_breaks
doc: "List the targeted genes in which a copy number breakpoint occurs.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Processed sample coverage data file (*.cnr), the output of the 'fix' sub-command."
    inputBinding:
      position: 1
  - id: segment
    type: File
    doc: "Segmentation calls (.cns), the output of the 'segment' command)."
    inputBinding:
      position: 2
  - id: min_probes
    type:
      - 'null'
      - int
    doc: "Minimum number of within-gene probes on both sides of a breakpoint to report it. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --min-probes
  - id: output
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output table file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
