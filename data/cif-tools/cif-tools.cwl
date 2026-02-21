cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif-tools
label: cif-tools
doc: "The provided text does not contain help information or usage instructions for
  cif-tools. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure during image extraction.\n\nTool
  homepage: https://github.com/PDB-REDO/cif-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif-tools:1.0.12--h077b44d_0
stdout: cif-tools.out
