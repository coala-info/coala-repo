cwlVersion: v1.2
class: CommandLineTool
baseCommand: epik
label: epik
doc: "The provided text does not contain help information for the tool 'epik'. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the container due to insufficient disk space.\n
  \nTool homepage: https://github.com/phylo42/epik"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epik:0.2.0--h077b44d_2
stdout: epik.out
