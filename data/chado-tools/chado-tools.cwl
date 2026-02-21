cwlVersion: v1.2
class: CommandLineTool
baseCommand: chado-tools
label: chado-tools
doc: "The provided text does not contain help information or usage instructions for
  chado-tools. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to lack of disk space.\n\n
  Tool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools.out
