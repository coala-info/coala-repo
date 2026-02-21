cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2c_bam2reads.pl
label: seq2c_bam2reads.pl
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_bam2reads.pl.out
