cwlVersion: v1.2
class: CommandLineTool
baseCommand: mace_mace.py
label: mace_mace.py
doc: "MACE (Model-based Analysis of ChIP-Exo). Note: The provided text contains system
  error logs regarding container execution and disk space rather than the tool's help
  documentation.\n\nTool homepage: http://chipexo.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
stdout: mace_mace.py.out
