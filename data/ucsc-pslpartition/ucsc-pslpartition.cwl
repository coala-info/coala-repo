cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPartition
label: ucsc-pslpartition
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to fetch the image.
  pslPartition is a UCSC tool used to partition PSL files into smaller sets.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpartition:482--h0b57e2e_0
stdout: ucsc-pslpartition.out
