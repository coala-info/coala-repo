cwlVersion: v1.2
class: CommandLineTool
baseCommand: gor_pyspark
label: gor_pyspark
doc: "Genomic Ordered Relational (GOR) tool using PySpark (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/gorpipe/gor-pyspark"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gor_pyspark:3.22.6--pyh7cba7a3_0
stdout: gor_pyspark.out
