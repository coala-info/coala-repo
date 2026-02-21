cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - graph
label: womtool_womgraph
doc: "The provided text does not contain help information or argument definitions;
  it is an error log from a container runtime (Singularity/Apptainer) failing to pull
  the womtool image.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_womgraph.out
