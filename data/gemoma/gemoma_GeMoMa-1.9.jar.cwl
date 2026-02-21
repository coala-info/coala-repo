cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemoma
label: gemoma_GeMoMa-1.9.jar
doc: "GeMoMa (Gene Model Mapper) is a tool for homology-based gene prediction. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: http://www.jstacs.de/index.php/GeMoMa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemoma:1.9--hdfd78af_0
stdout: gemoma_GeMoMa-1.9.jar.out
