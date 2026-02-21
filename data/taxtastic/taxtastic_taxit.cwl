cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxit
label: taxtastic_taxit
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) attempting
  to fetch the taxtastic image.\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit.out
