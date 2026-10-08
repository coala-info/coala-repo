cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - directionality
label: fanc_directionality
doc: "Calculate directionality index for a Hic object.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input matrix (Hi-C, fold-change map, ...)."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file (FAN-C object), or file prefix for bed, gff or bigwig output (the window size is appended)."
    inputBinding:
      position: 2
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format of the output file. By default, this is a FAN-C DirectionalityIndex object, for maximum compatibility with other analyses. Other options are \"bed\", \"bigwig\", and \"gff\""
    inputBinding:
      position: 20
      prefix: --output-format
  - id: window_sizes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Window sizes in base pairs. You can also use abbreviated number format (i.e. 1.5M, 250kb, etc). If not specified, will choose the window sizes based on the matrix resolution r when calculating scores. Specifically: r*3, r*5, r*7, r*10, and r*15"
    inputBinding:
      position: 20
      prefix: --window-sizes
  - id: region
    type:
      - 'null'
      - string
    doc: "Region selector (<chr>:<start>-<end>) to only calculate directionality index for this region."
    inputBinding:
      position: 20
      prefix: --region
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: scores
    type:
      type: array
      items: File
    doc: "The directionality index object, or one file per window size for text formats."
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
