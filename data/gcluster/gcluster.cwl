cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcluster
label: gcluster
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool 'gcluster'.\n\nTool homepage:
  http://www.microbialgenomic.com/Gcluster_tool.html/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcluster:2.06--hdfd78af_2
stdout: gcluster.out
