cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraSync
label: ucsc-parahub_paraSync
doc: "The provided text does not contain help information for the tool. It appears
  to be a set of system logs and a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build the container image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraSync.out
