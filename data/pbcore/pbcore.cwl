cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbcore
label: pbcore
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating that
  the 'pbcore' executable was not found in the system path.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcore:2.1.2--py_2
stdout: pbcore.out
