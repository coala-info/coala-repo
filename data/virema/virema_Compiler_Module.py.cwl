cwlVersion: v1.2
class: CommandLineTool
baseCommand: virema_Compiler_Module.py
label: virema_Compiler_Module.py
doc: "ViReMa (Viral Recombination Mapper) Compiler Module. Note: The provided text
  appears to be a container build log rather than help text; therefore, no arguments
  could be extracted.\n\nTool homepage: https://sourceforge.net/projects/virema/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virema:0.6--py27_0
stdout: virema_Compiler_Module.py.out
