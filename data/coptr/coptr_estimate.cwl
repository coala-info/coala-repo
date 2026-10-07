cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coptr
  - estimate
label: coptr_estimate
doc: "Estimate PTR table from coverage maps.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: coverage_map_folder
    type: Directory
    doc: Folder with coverage maps computed from 'extract'.
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: Filename to store PTR table (.csv is added when missing).
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
      - string
    doc: Plot model fit and save the results (name of the plot output 
      folder).
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
  - id: ptr_table
    type: File
    doc: Table of log2(PTR) estimates per genome and sample.
    outputBinding:
      glob: "$(inputs.out_file.endsWith('.csv') ? inputs.out_file : inputs.out_file\
        \ + '.csv')"
  - id: plot_folder
    type:
      - 'null'
      - Directory
    doc: Folder with the model fit plots (with --plot).
    outputBinding:
      glob: $(inputs.plot)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.coverage_map_folder)
        writable: true
      - entry: "$(inputs.plot ? {class: 'Directory', basename: inputs.plot, listing: []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
stdout: coptr_estimate.out
