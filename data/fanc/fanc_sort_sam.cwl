cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - sort-sam
label: fanc_sort_sam
doc: "Sort a SAM/BAM file by read name (same as 'samtools sort -n').\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: sam
    type: File
    doc: "Input SAM/BAM."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output SAM/BAM."
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of sorting threads (only when sambamba is available). Default: 1"
    inputBinding:
      position: 20
      prefix: --threads
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: sorted
    type: File
    doc: "Name-sorted SAM/BAM."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
