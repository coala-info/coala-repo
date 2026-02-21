cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_regroup_table
label: humann_humann_regroup_table
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain help information or arguments for the tool. No arguments could
  be extracted.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
stdout: humann_humann_regroup_table.out
