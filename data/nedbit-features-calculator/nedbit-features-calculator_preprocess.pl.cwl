cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator_preprocess.pl
label: nedbit-features-calculator_preprocess.pl
doc: "A preprocessing script for the Nedbit features calculator. (Note: The provided
  text contains container runtime error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/AndMastro/NIAPU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h7b50bb2_2
stdout: nedbit-features-calculator_preprocess.pl.out
