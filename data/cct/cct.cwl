cwlVersion: v1.2
class: CommandLineTool
baseCommand: cct
label: cct
doc: "The provided text appears to be a system error log from a container runtime
  (Apptainer/Singularity) rather than the help text for the 'cct' tool. As a result,
  no command-line arguments, descriptions, or usage instructions could be extracted.\n
  \nTool homepage: https://github.com/Eanya-Tonic/CCTV_Viewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
stdout: cct.out
