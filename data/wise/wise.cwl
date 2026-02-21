cwlVersion: v1.2
class: CommandLineTool
baseCommand: wise
label: wise
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the 'wise' tool.\n\nTool homepage:
  https://github.com/krishnadey30/LeetCode-Questions-CompanyWise"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/wise:v2.4.1-21-deb_cv1
stdout: wise.out
