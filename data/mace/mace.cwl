cwlVersion: v1.2
class: CommandLineTool
baseCommand: mace
label: mace
doc: "The provided text does not contain help information or usage instructions for
  the tool 'mace'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to insufficient disk
  space.\n\nTool homepage: http://chipexo.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
stdout: mace.out
