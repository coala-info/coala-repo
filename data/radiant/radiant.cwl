cwlVersion: v1.2
class: CommandLineTool
baseCommand: radiant
label: radiant
doc: "The provided text appears to be a container execution/build log rather than
  help text. No arguments or descriptions could be extracted from the input.\n\nTool
  homepage: https://domainworld.uni-muenster.de/data/radiant-db/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/radiant:v2.7dfsg-2-deb_cv1
stdout: radiant.out
