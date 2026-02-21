cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygraphviz
label: pygraphviz
doc: "The provided text does not contain help information or usage instructions for
  pygraphviz. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch a container image.\n\nTool homepage: https://github.com/pygraphviz/pygraphviz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygraphviz:1.3.1--py36_0
stdout: pygraphviz.out
