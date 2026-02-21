cwlVersion: v1.2
class: CommandLineTool
baseCommand: test_seqtk
label: test_seqtk
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build or execution process.\n\nTool homepage:
  https://github.com/lh3/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/test:0.1--h73052cd_7
stdout: test_seqtk.out
