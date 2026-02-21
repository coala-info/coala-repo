cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxquant_MaxQuantCmd.exe
label: maxquant_MaxQuantCmd.exe
doc: "MaxQuant command line tool for quantitative proteomics research.\n\nTool homepage:
  http://www.coxdocs.org/doku.php?id=maxquant:start"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxquant:2.0.3.0--py310hdfd78af_1
stdout: maxquant_MaxQuantCmd.exe.out
