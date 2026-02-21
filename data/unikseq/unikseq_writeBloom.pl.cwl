cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq_writeBloom.pl
label: unikseq_writeBloom.pl
doc: "The provided text does not contain help information for the tool; it appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_writeBloom.pl.out
