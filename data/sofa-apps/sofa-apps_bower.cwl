cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-apps_bower
label: sofa-apps_bower
doc: "A tool within the sofa-apps suite. Note: The provided text is an error log from
  a container build process and does not contain usage instructions or argument definitions.\n
  \nTool homepage: https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps_bower.out
