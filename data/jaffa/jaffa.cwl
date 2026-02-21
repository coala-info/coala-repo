cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa
label: jaffa
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa.out
