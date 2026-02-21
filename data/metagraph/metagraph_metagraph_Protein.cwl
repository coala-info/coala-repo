cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagraph
label: metagraph_metagraph_Protein
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to insufficient disk space, rather
  than the help text for the tool itself.\n\nTool homepage: https://github.com/ratschlab/metagraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagraph:0.5.0--haea4672_0
stdout: metagraph_metagraph_Protein.out
