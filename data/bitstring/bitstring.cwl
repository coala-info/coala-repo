cwlVersion: v1.2
class: CommandLineTool
baseCommand: bitstring
label: bitstring
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) and does not contain CLI help information or argument definitions.\n\
  \nTool homepage: https://github.com/scott-griffiths/bitstring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bitstring:3.1.5--py27_1
stdout: bitstring.out
