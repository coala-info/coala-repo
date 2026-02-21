cwlVersion: v1.2
class: CommandLineTool
baseCommand: gargammel.pl
label: gargammel_gargammel.pl
doc: "The provided text does not contain help information for the tool; it consists
  of system error logs related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel:1.1.4--hb66fcc3_0
stdout: gargammel_gargammel.pl.out
