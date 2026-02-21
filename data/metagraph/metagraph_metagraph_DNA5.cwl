cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagraph
label: metagraph_metagraph_DNA5
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/ratschlab/metagraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagraph:0.5.0--haea4672_0
stdout: metagraph_metagraph_DNA5.out
