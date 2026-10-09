cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_summary
label: illumina-interop_summary
doc: "Summary of the run metrics (cluster density, quality, error rate) per read and lane\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
  - id: level
    type:
      - 'null'
      - int
    doc: 'Level of summary information: 0: total, 1: non-index, 2: Read, 3: Lane, 4: Surface (default 5)'
    inputBinding:
      position: 102
      prefix: --level=
      separate: false
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
stdout: interop_summary.out
