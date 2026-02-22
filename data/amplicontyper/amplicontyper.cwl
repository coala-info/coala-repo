cwlVersion: v1.2
class: CommandLineTool
baseCommand: amplicontyper
label: amplicontyper
doc: "A tool for amplicon typing (Note: The provided text contains error logs from
  a container build process rather than the tool's help documentation, so specific
  arguments could not be extracted).\n\nTool homepage: https://github.com/AntonS-bio/AmpliconTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplicontyper:0.1.34--pyhdfd78af_0
stdout: amplicontyper.out
