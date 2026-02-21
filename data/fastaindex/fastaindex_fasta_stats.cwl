cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaindex_fasta_stats
label: fastaindex_fasta_stats
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build a container image
  due to lack of disk space.\n\nTool homepage: https://github.com/lpryszcz/FastaIndex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaindex:0.11c--py27_0
stdout: fastaindex_fasta_stats.out
