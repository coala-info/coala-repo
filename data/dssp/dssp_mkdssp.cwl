cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdssp
label: dssp_mkdssp
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/PDB-REDO/dssp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dssp:v3.0.0-3b1-deb_cv1
stdout: dssp_mkdssp.out
