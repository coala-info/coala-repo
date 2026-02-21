cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash
label: bamhash
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'bamhash'.\n
  \nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash.out
