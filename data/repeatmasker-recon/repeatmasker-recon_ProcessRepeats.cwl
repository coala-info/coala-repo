cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProcessRepeats
label: repeatmasker-recon_ProcessRepeats
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of container runtime log messages and a fatal error encountered
  while attempting to fetch or build the SIF image.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
stdout: repeatmasker-recon_ProcessRepeats.out
