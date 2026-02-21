cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomegranate
label: pomegranate
doc: "The provided text is a container build log indicating a failure to fetch the
  OCI image for pomegranate and does not contain CLI help information or argument
  definitions.\n\nTool homepage: https://github.com/jmschrei/pomegranate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomegranate:0.3.7--py36_2
stdout: pomegranate.out
