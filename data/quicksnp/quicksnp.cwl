cwlVersion: v1.2
class: CommandLineTool
baseCommand: quicksnp
label: quicksnp
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build or image fetch operation.\n\nTool
  homepage: https://github.com/k-florek/QuickSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quicksnp:1.0.1--py311hdfd78af_0
stdout: quicksnp.out
