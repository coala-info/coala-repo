cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_dumpbin
label: illumina-interop_dumpbin
doc: "Dump the raw binary InterOp files as numbers\n\nTool homepage: http://illumina.github.io/interop/index.html"
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
    doc: Display only a subset of records from each file
    inputBinding:
      position: 102
      prefix: --subset=
      separate: false
  - id: latest_version
    type:
      - 'null'
      - boolean
    doc: Display file as latest version of the format
    inputBinding:
      position: 102
      prefix: --latest_version=1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_dumpbin.out
