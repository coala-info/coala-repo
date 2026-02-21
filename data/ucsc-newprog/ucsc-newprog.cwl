cwlVersion: v1.2
class: CommandLineTool
baseCommand: newProg
label: ucsc-newprog
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newprog:482--h0b57e2e_0
stdout: ucsc-newprog.out
