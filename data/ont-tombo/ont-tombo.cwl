cwlVersion: v1.2
class: CommandLineTool
baseCommand: tombo
label: ont-tombo
doc: "Tombo is a suite of tools for the identification of modified nucleotides from
  nanopore sequencing data. (Note: The provided text is a system error message and
  does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py36r36h39af1c6_2
stdout: ont-tombo.out
