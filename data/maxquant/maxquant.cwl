cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxquant
label: maxquant
doc: "MaxQuant is a quantitative proteomics software package. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments.)\n\nTool homepage: http://www.coxdocs.org/doku.php?id=maxquant:start"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxquant:2.0.3.0--py310hdfd78af_1
stdout: maxquant.out
