cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr_estimate
label: coptr_estimate
doc: "Estimate PTR table from coverage maps.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: coverage_map_folder
    type: Directory
    doc: Folder with coverage maps computed from 'extract'.
    inputBinding:
      position: 1
  - id: out_file
    type: File
    doc: Filename to store PTR table.
    inputBinding:
      position: 2
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Fraction of nonzero bins required to compute a PTR
    inputBinding:
      position: 103
      prefix: --min-cov
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to compute a PTR
    inputBinding:
      position: 103
      prefix: --min-reads
  - id: min_samples
    type:
      - 'null'
      - int
    doc: CoPTRContig only. Minimum number of samples required to reorder bins
    inputBinding:
      position: 103
      prefix: --min-samples
  - id: plot
    type:
      - 'null'
      - Directory
    doc: Plot model fit and save the results.
    inputBinding:
      position: 103
      prefix: --plot
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Restarts the estimation step using the genomes in the 
      coverage-maps-genome folder.
    inputBinding:
      position: 103
      prefix: --restart
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
stdout: coptr_estimate.out
