cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipk
label: ipk
doc: "The provided text does not contain help information for the tool 'ipk'. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/phylo42/ipk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipk:0.5.1--h077b44d_4
stdout: ipk.out
