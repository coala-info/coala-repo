cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutadapt
label: cutadapt
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain the help text or usage information for cutadapt. As a result,
  no arguments could be extracted.\n\nTool homepage: https://cutadapt.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutadapt:5.2--py311haab0aaa_0
stdout: cutadapt.out
