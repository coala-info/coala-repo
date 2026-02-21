cwlVersion: v1.2
class: CommandLineTool
baseCommand: ragout
label: ragout
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/fenderglass/Ragout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragout:2.3--py36hc9558a2_0
stdout: ragout.out
