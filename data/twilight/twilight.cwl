cwlVersion: v1.2
class: CommandLineTool
baseCommand: twilight
label: twilight
doc: "The provided text does not contain help information or a description for the
  tool 'twilight'. It appears to be an error log from a failed container build process
  (no space left on device).\n\nTool homepage: https://github.com/TurakhiaLab/TWILIGHT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twilight:0.2.3--h6bb9b41_1
stdout: twilight.out
