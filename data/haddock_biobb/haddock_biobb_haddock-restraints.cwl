cwlVersion: v1.2
class: CommandLineTool
baseCommand: haddock-restraints
label: haddock_biobb_haddock-restraints
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to lack of disk space.\n\nTool homepage: https://github.com/haddocking/haddock3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haddock_biobb:2025.5--py39he88f293_3
stdout: haddock_biobb_haddock-restraints.out
