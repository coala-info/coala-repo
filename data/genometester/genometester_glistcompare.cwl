cwlVersion: v1.2
class: CommandLineTool
baseCommand: glistcompare
label: genometester_glistcompare
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs regarding a container execution failure (no
  space left on device).\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_glistcompare.out
