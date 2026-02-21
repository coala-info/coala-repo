cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat-lncrna
label: ctat-lncrna
doc: "The provided text does not contain help information or usage instructions. It
  contains system logs and a fatal error message regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/NCIP/ctat-lncrna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-lncrna:1.0.1--py27_0
stdout: ctat-lncrna.out
