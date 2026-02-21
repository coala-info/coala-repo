cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio_hansel
label: bio_hansel
doc: "Subtyping of Salmonella enterica subsp. enterica serovar Heidelberg and Enteritidis
  genomes\n\nTool homepage: https://github.com/phac-nml/bio_hansel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio_hansel:2.6.1--py_0
stdout: bio_hansel.out
