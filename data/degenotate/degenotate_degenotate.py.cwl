cwlVersion: v1.2
class: CommandLineTool
baseCommand: degenotate_degenotate.py
label: degenotate_degenotate.py
doc: "A tool for characterizing the degeneracy of sites in a genome. (Note: The provided
  help text contained only system error messages regarding container execution and
  did not list command-line arguments.)\n\nTool homepage: https://github.com/harvardinformatics/degenotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/degenotate:1.3--pyhdfd78af_0
stdout: degenotate_degenotate.py.out
