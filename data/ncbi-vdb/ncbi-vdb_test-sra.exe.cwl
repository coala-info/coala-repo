cwlVersion: v1.2
class: CommandLineTool
baseCommand: test-sra
label: ncbi-vdb_test-sra.exe
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container image building.\n\nTool
  homepage: https://github.com/ncbi/ncbi-vdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-vdb:3.3.0--h9948957_0
stdout: ncbi-vdb_test-sra.exe.out
