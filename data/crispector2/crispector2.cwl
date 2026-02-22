cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispector2
label: crispector2
doc: "The provided text is a container runtime error log and does not contain CLI
  help information or argument definitions. CRISPECTOR2 is a tool for analyzing CRISPR-Cas9
  genome editing experiments from NGS data.\n\nTool homepage: https://github.com/theAguy/crispector2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispector2:2.1.2--pyhdfd78af_0
stdout: crispector2.out
