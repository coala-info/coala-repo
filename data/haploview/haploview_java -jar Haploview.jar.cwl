cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - Haploview.jar
label: haploview_java -jar Haploview.jar
doc: "Haploview is a tool for haplotype analysis and visualization. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments).\n\nTool homepage: https://www.broadinstitute.org/haploview/haploview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploview:4.2--hdfd78af_1
stdout: haploview_java -jar Haploview.jar.out
