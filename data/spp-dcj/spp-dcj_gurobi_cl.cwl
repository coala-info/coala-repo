cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj_gurobi_cl
label: spp-dcj_gurobi_cl
doc: "Synteny Phylogeny Pipeline - Double Cut and Join (Gurobi solver). Note: The
  provided help text contains only container runtime error messages and no usage information.\n
  \nTool homepage: https://github.com/codialab/spp-dcj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj_gurobi_cl.out
