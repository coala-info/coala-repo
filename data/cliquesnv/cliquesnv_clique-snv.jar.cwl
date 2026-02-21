cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - clique-snv.jar
label: cliquesnv_clique-snv.jar
doc: "CliqueSNV is a tool for reconstructing rare haplotypes from NGS data. Note:
  The provided help text contains only system error logs regarding a container build
  failure ('no space left on device') and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/vtsyvina/CliqueSNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cliquesnv:2.0.3--hdfd78af_0
stdout: cliquesnv_clique-snv.jar.out
