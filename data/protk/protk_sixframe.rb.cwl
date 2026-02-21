cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_sixframe.rb
label: protk_sixframe.rb
doc: "A tool for six-frame translation of DNA sequences (Note: The provided text contains
  system error logs rather than help documentation, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_sixframe.rb.out
