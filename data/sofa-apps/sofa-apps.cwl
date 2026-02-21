cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-apps
label: sofa-apps
doc: "The provided text appears to be a container build log or error message rather
  than a help menu. No command-line arguments or tool descriptions were found in the
  input.\n\nTool homepage: https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps.out
