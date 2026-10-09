cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_aggregate
label: illumina-interop_aggregate
doc: "Aggregate the tile metrics of a run into summary rows\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
  - id: max_tile
    type:
      - 'null'
      - int
    doc: Maximum tile number to include
    inputBinding:
      position: 102
      prefix: --max-tile=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_aggregate.out
