cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsearch
label: infernal_cmsearch
doc: "The provided text does not contain help information as it is an error log reporting
  a 'no space left on device' failure during a container build. No arguments could
  be extracted.\n\nTool homepage: http://eddylab.org/infernal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmsearch.out
