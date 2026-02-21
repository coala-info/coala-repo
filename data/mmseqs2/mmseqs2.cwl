cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmseqs
label: mmseqs2
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the mmseqs2 tool. The
  error indicates a failure to create a build directory due to insufficient disk space.\n
  \nTool homepage: https://github.com/soedinglab/mmseqs2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
stdout: mmseqs2.out
