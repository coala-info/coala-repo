cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdfinder_makeblastdb
label: hsdfinder_makeblastdb
doc: "The provided text is an error log indicating a failure to build or pull the
  container image due to insufficient disk space and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/zx0223winner/HSDFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
stdout: hsdfinder_makeblastdb.out
