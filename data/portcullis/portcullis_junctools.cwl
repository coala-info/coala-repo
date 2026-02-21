cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - portcullis
  - junctools
label: portcullis_junctools
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/maplesond/portcullis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
stdout: portcullis_junctools.out
