cwlVersion: v1.2
class: CommandLineTool
baseCommand: libsequence
label: libsequence
doc: "A C++ class library for evolutionary genetic analysis. (Note: The provided text
  is a container engine error log and does not contain CLI help documentation or argument
  definitions.)\n\nTool homepage: http://http://molpopgen.github.io/libsequence/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libsequence:1.9.8--h6bb024c_0
stdout: libsequence.out
