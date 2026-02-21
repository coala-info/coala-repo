cwlVersion: v1.2
class: CommandLineTool
baseCommand: openmg
label: openmg
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'openmg'.\n
  \nTool homepage: https://github.com/aristanetworks/openmgmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openmg:0.1--0
stdout: openmg.out
