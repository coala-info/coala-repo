cwlVersion: v1.2
class: CommandLineTool
baseCommand: estOrient
label: ucsc-estorient
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log from Apptainer/Singularity.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-estorient:482--h0b57e2e_0
stdout: ucsc-estorient.out
