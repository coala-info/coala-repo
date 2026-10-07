cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - target
label: cnvkit_target
doc: "Transform bait intervals into targets more suitable for CNVkit.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: interval
    type: File
    doc: "BED or interval file listing the targeted regions."
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - File
    doc: "Use gene models from this file to assign names to the target regions. Format: UCSC refFlat.txt or ensFlat.txt file (preferred), or BED, interval list, GFF, or similar."
    inputBinding:
      position: 101
      prefix: --annotate
  - id: short_names
    type:
      - 'null'
      - boolean
    doc: "Reduce multi-accession bait labels to be short and consistent."
    inputBinding:
      position: 101
      prefix: --short-names
  - id: split
    type:
      - 'null'
      - boolean
    doc: "Split large tiled intervals into smaller, consecutive targets."
    inputBinding:
      position: 101
      prefix: --split
  - id: avg_size
    type:
      - 'null'
      - int
    doc: "Average size of split target bins (results are approximate). [Default: 266.6666666666667]"
    inputBinding:
      position: 101
      prefix: --avg-size
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
