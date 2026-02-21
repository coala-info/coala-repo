cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin-ref
label: ribotin_ribotin-ref
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution attempt.\n
  \nTool homepage: https://github.com/maickrau/ribotin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotin:1.5--h077b44d_0
stdout: ribotin_ribotin-ref.out
