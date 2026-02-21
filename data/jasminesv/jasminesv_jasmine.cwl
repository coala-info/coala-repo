cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasmine
label: jasminesv_jasmine
doc: "Jasmine is a tool for merging structural variant calls. (Note: The provided
  help text contains only system error messages and no argument definitions.)\n\n
  Tool homepage: https://github.com/mkirsche/Jasmine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv_jasmine.out
