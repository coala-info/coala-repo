cwlVersion: v1.2
class: CommandLineTool
baseCommand: igvtools
label: igvtools
doc: "The provided text does not contain help documentation for the tool. It contains
  system log messages and a fatal error indicating a failure to build or run the container
  image due to insufficient disk space.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
stdout: igvtools.out
