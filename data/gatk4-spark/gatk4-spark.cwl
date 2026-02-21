cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatk
label: gatk4-spark
doc: "The provided text does not contain help information or usage instructions. It
  contains system error logs related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatk4-spark:4.6.2.0--hdfd78af_1
stdout: gatk4-spark.out
