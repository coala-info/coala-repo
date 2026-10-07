cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - metrics
label: cnvkit_metrics
doc: "Compute coverage deviations and other metrics for self-evaluation.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: cnarrays
    type:
      type: array
      items: File
    doc: "One or more bin-level coverage data files (*.cnn, *.cnr)."
    inputBinding:
      position: 1
  - id: segments
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more segmentation data files (*.cns, output of the 'segment' command). If more than one file is given, the number must match the coverage data files, in which case the input files will be paired together in the given order. Otherwise, the same segments will be used for all coverage files."
    inputBinding:
      position: 101
      prefix: --segments
  - id: drop_low_coverage
    type:
      - 'null'
      - boolean
    doc: "Drop very-low-coverage bins before calculations to reduce negative \"fat tail\" of bin log2 values in poor-quality tumor samples."
    inputBinding:
      position: 101
      prefix: --drop-low-coverage
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
