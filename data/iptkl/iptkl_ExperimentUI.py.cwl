cwlVersion: v1.2
class: CommandLineTool
baseCommand: iptkl_ExperimentUI.py
label: iptkl_ExperimentUI.py
doc: "A tool from the IPTKL (Immunotherapy Toolkit) suite. Note: The provided text
  contains system error messages regarding container execution and does not include
  usage instructions or argument definitions.\n\nTool homepage: https://github.com/ikmb/iptoolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iptkl:0.6.8--pyh5e36f6f_0
stdout: iptkl_ExperimentUI.py.out
