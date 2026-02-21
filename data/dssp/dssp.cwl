cwlVersion: v1.2
class: CommandLineTool
baseCommand: dssp
label: dssp
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'dssp' tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/PDB-REDO/dssp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dssp:v3.0.0-3b1-deb_cv1
stdout: dssp.out
