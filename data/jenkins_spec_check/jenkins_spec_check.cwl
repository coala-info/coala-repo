cwlVersion: v1.2
class: CommandLineTool
baseCommand: jenkins_spec_check
label: jenkins_spec_check
doc: "A tool for checking Jenkins specifications. (Note: The provided text appears
  to be a container runtime error log rather than help text, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/vshalunov/book_store_api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jenkins_spec_check:latest
stdout: jenkins_spec_check.out
