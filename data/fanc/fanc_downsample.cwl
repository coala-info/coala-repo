cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - downsample
label: fanc_downsample
doc: "Downsample contacts from a Hic object (deprecated: fanc hic --downsample does the same).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: hic
    type: File
    doc: "Hic object to be downsampled."
    inputBinding:
      position: 1
  - id: n
    type: string
    doc: "Sample size, or fraction of valid pairs when < 1."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Downsampled Hic output."
    inputBinding:
      position: 3
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: hic_out
    type: File
    doc: "Downsampled Hic object."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
