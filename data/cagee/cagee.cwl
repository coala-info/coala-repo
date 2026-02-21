cwlVersion: v1.2
class: CommandLineTool
baseCommand: cagee
label: cagee
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cagee'. It appears to be a log of a failed container build/execution error
  (no space left on device).\n\nTool homepage: https://github.com/hahnlab/CAGEE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cagee:1.2--he96a11b_1
stdout: cagee.out
