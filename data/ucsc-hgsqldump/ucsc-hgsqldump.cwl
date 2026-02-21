cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-hgsqldump
label: ucsc-hgsqldump
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  while attempting to fetch the tool image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgsqldump:482--h0b57e2e_0
stdout: ucsc-hgsqldump.out
