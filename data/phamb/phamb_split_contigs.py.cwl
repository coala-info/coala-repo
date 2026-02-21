cwlVersion: v1.2
class: CommandLineTool
baseCommand: phamb_split_contigs.py
label: phamb_split_contigs.py
doc: "The provided text contains system error messages regarding a failed container
  build (no space left on device) and does not contain help text or usage information
  for the tool.\n\nTool homepage: https://github.com/RasmussenLab/phamb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phamb:1.0.1--pyhdfd78af_0
stdout: phamb_split_contigs.py.out
