cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapsearch
label: rapsearch
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool 'rapsearch'.\n\n
  Tool homepage: https://github.com/zhaoyanswill/RAPSearch2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapsearch:2.24--1
stdout: rapsearch.out
