cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr rabun
label: coptr_rabun
doc: "Computes the PTR table from coverage maps.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: coverage_map_folder
    type: Directory
    doc: Folder with coverage maps computed from 'extract'.
    inputBinding:
      position: 1
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Fraction of nonzero bins required to compute a PTR
    default: 0.75
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to compute a PTR
    default: 5000
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: min_samples
    type:
      - 'null'
      - int
    doc: CoPTRContig only. Minimum number of samples required to reorder bins
    default: 5
    inputBinding:
      position: 102
      prefix: --min-samples
outputs:
  - id: out_file
    type: File
    doc: Filename to store PTR table.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
