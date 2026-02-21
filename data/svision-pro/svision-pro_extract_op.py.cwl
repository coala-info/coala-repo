cwlVersion: v1.2
class: CommandLineTool
baseCommand: svision-pro_extract_op.py
label: svision-pro_extract_op.py
doc: "A script within the SVision-pro toolset, likely used for extracting operations
  or features from genomic data. (Note: The provided text is a container runtime error
  log and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/songbowang125/SVision-pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svision-pro:2.5--pyhdfd78af_0
stdout: svision-pro_extract_op.py.out
