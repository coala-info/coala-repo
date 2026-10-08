cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - subset
label: fanc_subset
doc: "Create a new Hic object by subsetting it to some regions.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input Hic file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output Hic file."
    inputBinding:
      position: 2
  - id: regions
    type:
      type: array
      items: string
    doc: "Regions for the output Hic object, e.g. 'chr1' 'chr3' or 'chr1:1-500000'."
    inputBinding:
      position: 3
outputs:
  - id: hic
    type: File
    doc: "Subset Hic object."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
