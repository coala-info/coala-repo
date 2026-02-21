cwlVersion: v1.2
class: CommandLineTool
baseCommand: PolyATrimmer
label: dropseq_tools_PolyATrimmer
doc: "A tool from the Drop-seq software suite. (Note: The provided help text contains
  only system error messages regarding container execution and does not list any command-line
  arguments.)\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_PolyATrimmer.out
