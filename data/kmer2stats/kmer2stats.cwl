cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer2stats
label: kmer2stats
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image creation
  (no space left on device).\n\nTool homepage: https://github.com/SantaMcCloud/kmer2stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer2stats:1.0.1--pyhdfd78af_0
stdout: kmer2stats.out
