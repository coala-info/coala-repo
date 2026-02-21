cwlVersion: v1.2
class: CommandLineTool
baseCommand: customtkinter
label: customtkinter
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://customtkinter.tomschimansky.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/customtkinter:5.2.2--pyh7cba7a3_0
stdout: customtkinter.out
