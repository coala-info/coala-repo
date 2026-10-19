cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_structdr.py
label: quasildr_run_structdr.py
doc: "Run nonparametric ridge estimation (StructDR).\n\nTool homepage: https://github.com/jzthree/quasildr"
inputs:
  - id: input
    type: File
    doc: "Input file"
    inputBinding:
      position: 1
      prefix: --input
  - id: anno_file
    type:
      - 'null'
      - File
    doc: "Annotation file for plotting"
    inputBinding:
      position: 1
      prefix: --anno_file
  - id: anno_column
    type:
      - 'null'
      - string
    doc: "Name of the column to use in annotation file (default group_id)"
    inputBinding:
      position: 1
      prefix: --anno_column
  - id: output
    type: string
    doc: "Output prefix"
    inputBinding:
      position: 1
      prefix: --output
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Output suffix"
    inputBinding:
      position: 1
      prefix: --suffix
  - id: niter
    type:
      - 'null'
      - int
    doc: "Number of iterations. Default is 30."
    inputBinding:
      position: 1
      prefix: --niter
  - id: ndim
    type:
      - 'null'
      - int
    doc: "Number of input dimensions to use. Default is 15."
    inputBinding:
      position: 1
      prefix: --ndim
  - id: bw
    type:
      - 'null'
      - float
    doc: "Gaussian KDE kernel bandwidth. Not needed if automatic_bw is specified. Default is 0."
    inputBinding:
      position: 1
      prefix: --bw
  - id: adaptive_bw
    type:
      - 'null'
      - int
    doc: "Set data point-specific minimum bandwidth to its distance to the adaptive_bw-th nearest neighbor. Default is 10."
    inputBinding:
      position: 1
      prefix: --adaptive_bw
  - id: automatic_bw
    type:
      - 'null'
      - float
    doc: "Use pca to select bw. Default is 2.0."
    inputBinding:
      position: 1
      prefix: --automatic_bw
  - id: relaxation
    type:
      - 'null'
      - float
    doc: "Ridge dimensionality relaxation. Default is 0."
    inputBinding:
      position: 1
      prefix: --relaxation
  - id: stepsize
    type:
      - 'null'
      - float
    doc: "Step size relative to standard SCMS. Default is 0.5."
    inputBinding:
      position: 1
      prefix: --stepsize
  - id: method
    type:
      - 'null'
      - string
    doc: "Method. Default is LocInv"
    inputBinding:
      position: 1
      prefix: --method
  - id: batchsize
    type:
      - 'null'
      - int
    doc: "Decreasing the batch size reduces memory consumption. Default is 500."
    inputBinding:
      position: 1
      prefix: --batchsize
  - id: ridge_dimensionality
    type:
      - 'null'
      - float
    doc: "Ridge dimensionality. Default is 1."
    inputBinding:
      position: 1
      prefix: --ridge_dimensionality
  - id: bigdata
    type:
      - 'null'
      - boolean
    doc: "Speed up computation for big datasets with multilevel data representation (experimental)."
    inputBinding:
      position: 1
      prefix: --bigdata
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: "Number of jobs"
    inputBinding:
      position: 1
      prefix: --n_jobs
  - id: extract_backbone
    type:
      - 'null'
      - boolean
    doc: "Extract backbones"
    inputBinding:
      position: 1
      prefix: --extract_backbone
  - id: k
    type:
      - 'null'
      - int
    doc: "Number of NN to prescreen edges. Default is 50."
    inputBinding:
      position: 1
      prefix: --k
  - id: maxangle
    type:
      - 'null'
      - float
    doc: "Prefilter edges by angles. Default is 90."
    inputBinding:
      position: 1
      prefix: --maxangle
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
stdout: quasildr_run_structdr.py.out
