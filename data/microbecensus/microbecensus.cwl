cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_microbe_census.py
label: microbecensus
doc: "The provided text does not contain help information for microbecensus; it contains
  container runtime error messages indicating a 'no space left on device' failure
  during image conversion.\n\nTool homepage: https://github.com/snayfach/MicrobeCensus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microbecensus:1.1.1--0
stdout: microbecensus.out
