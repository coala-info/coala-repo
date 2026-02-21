cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylartist
label: methylartist
doc: "A tool for visualizing and analyzing DNA methylation data (Note: The provided
  text contains container runtime error messages rather than tool help text).\n\n
  Tool homepage: https://github.com/adamewing/methylartist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
stdout: methylartist.out
