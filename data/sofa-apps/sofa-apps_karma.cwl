cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sofa-apps
  - karma
label: sofa-apps_karma
doc: "SOFA (Simulation Open Framework Architecture) application - karma\n\nTool homepage:
  https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps_karma.out
