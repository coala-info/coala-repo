cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-apps_git
label: sofa-apps_git
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container build or execution process.\n\nTool
  homepage: https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps_git.out
