cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_kmer
label: fasten_fasten_kmer
doc: "A tool for k-mer analysis within the fasten suite. (Note: The provided help
  text contains system error messages and does not list specific arguments.)\n\nTool
  homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_kmer.out
