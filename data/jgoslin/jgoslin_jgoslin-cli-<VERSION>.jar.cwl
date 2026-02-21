cwlVersion: v1.2
class: CommandLineTool
baseCommand: jgoslin
label: jgoslin_jgoslin-cli-<VERSION>.jar
doc: "Java implementation of the Grammar of Lipid Nomenclature (Goslin) for parsing
  and normalizing lipid names.\n\nTool homepage: https://github.com/lifs-tools/jgoslin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jgoslin:2.2.0--hdfd78af_0
stdout: jgoslin_jgoslin-cli-<VERSION>.jar.out
