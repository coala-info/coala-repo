cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvetg
label: velvet_velvetg
doc: "The provided text contains error messages from a container runtime (Singularity/Apptainer)
  and does not include the help documentation for velvetg. As a result, no arguments
  could be parsed.\n\nTool homepage: https://github.com/dzerbino/velvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet:1.2.10--h7132678_5
stdout: velvet_velvetg.out
