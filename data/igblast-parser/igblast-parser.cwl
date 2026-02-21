cwlVersion: v1.2
class: CommandLineTool
baseCommand: igblast-parser
label: igblast-parser
doc: "A tool for parsing IgBLAST output. (Note: The provided text contains system
  error messages regarding container execution and does not include the tool's help
  documentation or argument list.)\n\nTool homepage: https://github.com/aerijman/igblast-parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igblast-parser:0.0.4--py39hf95cd2a_6
stdout: igblast-parser.out
