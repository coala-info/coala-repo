cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifihla
label: hifihla
doc: "A tool for HLA typing from PacBio HiFi reads (Note: The provided text is a system
  error log and does not contain usage information or argument descriptions).\n\n
  Tool homepage: https://github.com/PacificBiosciences/hifihla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
stdout: hifihla.out
