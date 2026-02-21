cwlVersion: v1.2
class: CommandLineTool
baseCommand: structure-threader
label: structure-threader
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://gitlab.com/StuntsPT/Structure_threader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/structure-threader:1.3.11--py313hdfd78af_1
stdout: structure-threader.out
