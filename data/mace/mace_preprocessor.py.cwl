cwlVersion: v1.2
class: CommandLineTool
baseCommand: mace_preprocessor.py
label: mace_preprocessor.py
doc: "The provided text does not contain help information for mace_preprocessor.py;
  it contains system log messages and a fatal error regarding container image creation
  (no space left on device).\n\nTool homepage: http://chipexo.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
stdout: mace_preprocessor.py.out
