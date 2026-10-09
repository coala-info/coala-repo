cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_index-summary
label: illumina-interop_index-summary
doc: "Summary of the index (demultiplexing) metrics per lane\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Format output as CSV only
    inputBinding:
      position: 102
      prefix: --csv=1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_index-summary.out
