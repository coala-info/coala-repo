cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coptr
  - count
label: coptr_count
doc: "Computes the PTR table from coverage maps.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: coverage_map_folder
    type: Directory
    doc: Folder with coverage maps computed from 'extract'.
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: Filename to store PTR table.
    inputBinding:
      position: 2
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Fraction of nonzero bins required to compute a PTR
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: min_samples
    type:
      - 'null'
      - int
    doc: CoPTRContig only. Minimum number of samples required to reorder bins
    inputBinding:
      position: 102
      prefix: --min-samples
outputs:
  - id: out_out_file
    type: File
    doc: Filename to store PTR table.
    outputBinding:
      glob: '$(inputs.out_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
