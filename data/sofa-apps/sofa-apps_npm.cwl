cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-apps_npm
label: sofa-apps_npm
doc: "The provided text does not contain help information for sofa-apps_npm. It appears
  to be a log of a failed container build or execution process.\n\nTool homepage:
  https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps_npm.out
