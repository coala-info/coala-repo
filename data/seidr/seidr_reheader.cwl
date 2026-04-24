cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr_reheader
label: seidr_reheader
doc: "Modify SeidrFile headers. Currently only drops disconnected nodes and resets
  stats.\n\nTool homepage: https://github.com/bschiffthaler/seidr"
inputs:
  - id: in_file
    type: File
    doc: Input SeidrFile
    inputBinding:
      position: 1
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary data
    inputBinding:
      position: 102
      prefix: --tempdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
stdout: seidr_reheader.out
