cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacerextractor
label: spacerextractor
doc: "A tool for extracting spacers from CRISPR arrays (Note: The provided text contains
  error logs rather than help text, so arguments could not be extracted).\n\nTool
  homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
stdout: spacerextractor.out
