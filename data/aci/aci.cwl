cwlVersion: v1.2
class: CommandLineTool
baseCommand: aci
label: aci
doc: "The provided text appears to be a system log or error message from a container
  runtime (Apptainer/Singularity) rather than the help text for the 'aci' tool itself.
  As a result, no command-line arguments, flags, or descriptions of the tool's functionality
  could be extracted from the input.\n\nTool homepage: https://github.com/erinyoung/ACI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aci:1.45.251125--pyhdfd78af_0
stdout: aci.out
