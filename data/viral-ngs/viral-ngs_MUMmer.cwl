cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viral-ngs
  - MUMmer
label: viral-ngs_MUMmer
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log. No arguments could be extracted.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_MUMmer.out
