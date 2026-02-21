cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoformcheck
label: isoformcheck
doc: "A tool for checking isoforms (Note: The provided help text contains only system
  error messages regarding container image conversion and disk space, so specific
  arguments could not be extracted).\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
stdout: isoformcheck.out
