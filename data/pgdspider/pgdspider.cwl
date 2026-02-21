cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgdspider
label: pgdspider
doc: "The provided text does not contain help information for pgdspider; it is an
  error log indicating a failure to build or extract a container image due to lack
  of disk space.\n\nTool homepage: http://www.cmpg.unibe.ch/software/PGDSpider/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgdspider:2.1.1.5--hdfd78af_1
stdout: pgdspider.out
