cwlVersion: v1.2
class: CommandLineTool
baseCommand: weblogo
label: weblogo
doc: "The provided text is an error log from a container execution environment (Apptainer/Singularity)
  and does not contain the help text or usage information for the weblogo tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/WebLogo/weblogo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/weblogo:3.7.9--pyhdfd78af_0
stdout: weblogo.out
