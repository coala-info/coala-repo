cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2c_lr2gene.pl
label: seq2c_lr2gene.pl
doc: "The provided text is a system error log (Singularity/Apptainer) indicating a
  failure to build or extract a container image due to 'no space left on device'.
  It does not contain help text or usage information for the tool seq2c_lr2gene.pl.\n
  \nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_lr2gene.pl.out
