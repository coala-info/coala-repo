cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - overlap-peaks
label: fanc_overlap_peaks
doc: "Overlap peaks (loops) from multiple samples.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input FAN-C peak files. Two or more."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output directory for overlapped peaks and stats."
    inputBinding:
      position: 2
  - id: distance
    type:
      - 'null'
      - int
    doc: "Maximum distance between peaks for merging them. Default=3x bin size"
    inputBinding:
      position: 20
      prefix: --distance
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names for input Peak samples. Default: Use file names"
    inputBinding:
      position: 20
      prefix: --names
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: out_dir
    type: Directory
    doc: "Overlapped peaks and stats."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
