cwlVersion: v1.2
class: CommandLineTool
baseCommand: singularity
label: singularity
doc: "A container platform for high-performance computing (HPC) and enterprise environments.\n
  \nTool homepage: http://singularity.lbl.gov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singularity:3.8.6
stdout: singularity.out
