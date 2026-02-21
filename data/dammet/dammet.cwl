cwlVersion: v1.2
class: CommandLineTool
baseCommand: dammet
label: dammet
doc: "The provided text does not contain help information or usage instructions for
  the tool 'dammet'. It contains system log messages and a fatal error regarding a
  container build failure (no space left on device).\n\nTool homepage: https://gitlab.com/KHanghoj/DamMet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dammet:1.0.1a--h1fa8866_0
stdout: dammet.out
