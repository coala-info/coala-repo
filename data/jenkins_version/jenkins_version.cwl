cwlVersion: v1.2
class: CommandLineTool
baseCommand: jenkins_version
label: jenkins_version
doc: "A tool to check Jenkins version information. (Note: The provided help text contains
  system error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/cirosantilli/china-dictatorship"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jenkins_spec_check:latest
stdout: jenkins_version.out
