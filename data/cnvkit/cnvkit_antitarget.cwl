cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - antitarget
label: cnvkit_antitarget
doc: "Derive off-target (\"antitarget\") bins from target regions.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: targets
    type: File
    doc: "BED or interval file listing the targeted regions."
    inputBinding:
      position: 1
  - id: access
    type:
      - 'null'
      - File
    doc: "Regions of accessible sequence on chromosomes (.bed), as output by genome2access.py."
    inputBinding:
      position: 101
      prefix: --access
  - id: avg_size
    type:
      - 'null'
      - int
    doc: "Average size of antitarget bins (results are approximate). [Default: 150000]"
    inputBinding:
      position: 101
      prefix: --avg-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: "Minimum size of antitarget bins (smaller regions are dropped). [Default: 1/16 avg size, calculated]"
    inputBinding:
      position: 101
      prefix: --min-size
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
