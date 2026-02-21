cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmap_rmapi
label: rmap_rmapi
doc: "The provided text does not contain help information for the tool; it appears
  to be a container build error log from Apptainer/Singularity.\n\nTool homepage:
  https://github.com/juruen/rmapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmap:2.1--0
stdout: rmap_rmapi.out
