cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - uropa2gtf.R
label: uropa_uropa2gtf.R
doc: "Reformat UROPA result tables to gtf file format.\n\nTool homepage: https://github.com/loosolab/UROPA"
inputs:
  - id: input
    type: File
    doc: input table from UROPA which should be reformatted to gtf file format
    inputBinding:
      position: 101
      prefix: --input
  - id: gtf_source
    type:
      - 'null'
      - string
    doc: gtf_source
    inputBinding:
      position: 101
      prefix: --gtf_source
  - id: feature
    type:
      - 'null'
      - string
    doc: feature
    inputBinding:
      position: 101
      prefix: --feature
  - id: threads
    type:
      - 'null'
      - int
    doc: cores to be used for reformatting
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gtf_files
    type:
      type: array
      items: File
    doc: gtf file written by uropa2gtf.R
    outputBinding:
      glob: '*.gtf'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0
stdout: uropa_uropa2gtf.R.out
