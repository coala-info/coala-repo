cwlVersion: v1.2
class: CommandLineTool
baseCommand: transcov_preprocess
label: transcov_preprocess
doc: "Preprocess annotation file for TransCov\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: annotation_file
    type: File
    doc: Annotation file
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file for regions
    inputBinding:
      position: 102
      prefix: --bed-file
  - id: region_size
    type:
      - 'null'
      - string
    doc: Region size (e.g., '1000' or '1kb')
    inputBinding:
      position: 102
      prefix: --region-size
  - id: tss_file
    type:
      - 'null'
      - File
    doc: TSS file for regions
    inputBinding:
      position: 102
      prefix: --tss-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_preprocess.out
