cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmat
label: cmat
doc: "The provided text does not contain help information for the tool 'cmat'. It
  contains error logs related to a container runtime failure (no space left on device)
  while attempting to pull the image from quay.io/biocontainers/cmat.\n\nTool homepage:
  https://github.com/EBIvariation/CMAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmat:3.4.3--py311hdfd78af_0
stdout: cmat.out
