cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-b-hooks-endofscope
label: perl-b-hooks-endofscope
doc: "B::Hooks::EndOfScope - Execute code after a scope finished compilation. (Note:
  The provided text contains system error logs regarding disk space and container
  conversion, not command-line help documentation.)\n\nTool homepage: https://github.com/karenetheridge/B-Hooks-EndOfScope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-b-hooks-endofscope:0.26--pl5321h9f5acd7_1
stdout: perl-b-hooks-endofscope.out
