cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-gather
label: bactopia-gather_bactopia-run
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a Singularity container execution failure
  (no space left on device).\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-gather:1.0.4--hdfd78af_0
stdout: bactopia-gather_bactopia-run.out
