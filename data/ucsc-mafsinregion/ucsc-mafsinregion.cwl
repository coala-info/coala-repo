cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-mafsinregion
label: ucsc-mafsinregion
doc: "The provided text is a container engine error log (Apptainer/Singularity) and
  does not contain the help text or usage information for the tool.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsinregion:482--h0b57e2e_0
stdout: ucsc-mafsinregion.out
