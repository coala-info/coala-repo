cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmwi2_gmwi2_metaphlan_output.py
label: gmwi2_gmwi2_metaphlan_output.py
doc: "A script for processing MetaPhlAn output within the GMWI2 (Gut Microbiome Health
  Index 2) workflow. Note: The provided text contains container runtime error messages
  rather than tool help documentation.\n\nTool homepage: https://github.com/danielchang2002/GMWI2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmwi2:1.6--pyhdfd78af_0
stdout: gmwi2_gmwi2_metaphlan_output.py.out
