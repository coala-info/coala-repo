cwlVersion: v1.2
class: CommandLineTool
baseCommand: refseq_masher
label: refseq_masher
doc: "The provided text does not contain help information or usage instructions for
  refseq_masher. It appears to be a log of a failed container build or execution process.\n
  \nTool homepage: https://github.com/phac-nml/refseq_masher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0
stdout: refseq_masher.out
