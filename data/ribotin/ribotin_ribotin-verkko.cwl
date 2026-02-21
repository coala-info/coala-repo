cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin-verkko
label: ribotin_ribotin-verkko
doc: "The provided text does not contain help information for the tool; it is a container
  execution error log indicating a failure to fetch the OCI image.\n\nTool homepage:
  https://github.com/maickrau/ribotin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotin:1.5--h077b44d_0
stdout: ribotin_ribotin-verkko.out
