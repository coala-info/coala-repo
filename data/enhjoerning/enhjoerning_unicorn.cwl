cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enhjoerning
  - unicorn
label: enhjoerning_unicorn
doc: "The provided text contains error logs and environment information rather than
  the tool's help documentation. As a result, no arguments could be extracted from
  the input.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn.out
