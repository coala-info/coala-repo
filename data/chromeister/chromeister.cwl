cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromeister
label: chromeister
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to extract the image due to lack of disk space.\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
stdout: chromeister.out
