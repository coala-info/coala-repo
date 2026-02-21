cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie
label: refgenconf_refgenie
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build process.\n\nTool homepage: https://refgenie.databio.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenconf:0.12.2--pyhdfd78af_0
stdout: refgenconf_refgenie.out
