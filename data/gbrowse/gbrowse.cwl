cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbrowse
label: gbrowse
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failure and does not include the actual help documentation
  or usage instructions for the gbrowse tool.\n\nTool homepage: https://github.com/edgafner/GBrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gbrowse:v2.56dfsg-4-deb_cv1
stdout: gbrowse.out
