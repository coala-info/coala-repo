cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira
label: chira
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the tool's image due to insufficient disk
  space.\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
stdout: chira.out
