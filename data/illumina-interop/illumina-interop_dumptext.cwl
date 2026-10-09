cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_dumptext
label: illumina-interop_dumptext
doc: Dump InterOp metric data as text
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
  - id: subset
    type:
      - 'null'
      - int
    doc: Number of metrics to subsample
    inputBinding:
      position: 102
      prefix: --subset=
      separate: false
  - id: metric
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --metric=
          separate: false
    doc: Name of metric to load, e.g. --metric=Tile to load TileMetricsOut.bin
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_dumptext.out
s:url: http://illumina.github.io/interop/index.html
$namespaces:
  s: https://schema.org/
