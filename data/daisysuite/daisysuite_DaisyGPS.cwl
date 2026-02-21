cwlVersion: v1.2
class: CommandLineTool
baseCommand: daisysuite DaisyGPS
label: daisysuite_DaisyGPS
doc: "The provided text does not contain help information for the tool, but rather
  log messages indicating a container runtime error (no space left on device).\n\n
  Tool homepage: https://gitlab.com/eseiler/DaisySuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daisysuite:1.3.0--hdfd78af_3
stdout: daisysuite_DaisyGPS.out
