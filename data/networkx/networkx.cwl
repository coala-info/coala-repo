cwlVersion: v1.2
class: CommandLineTool
baseCommand: networkx
label: networkx
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or documentation for the networkx tool. NetworkX
  is typically a Python library for studying graphs and networks.\n\nTool homepage:
  https://github.com/networkx/networkx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/networkx:1.11
stdout: networkx.out
