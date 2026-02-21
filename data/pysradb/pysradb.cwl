cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb
label: pysradb
doc: "A Python tool to query SRA metadata and download data from SRA/ENA.\n\nTool
  homepage: https://github.com/saketkc/pysradb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb.out
