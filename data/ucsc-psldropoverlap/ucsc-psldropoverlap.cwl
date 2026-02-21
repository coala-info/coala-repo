cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslDropOverlap
label: ucsc-psldropoverlap
doc: "The provided text does not contain help information for the tool. It appears
  to be a series of error messages from a container runtime (Singularity/Apptainer)
  failing to pull or build the image for ucsc-psldropoverlap.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psldropoverlap:482--h0b57e2e_0
stdout: ucsc-psldropoverlap.out
