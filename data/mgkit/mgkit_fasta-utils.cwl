cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgkit-fasta-utils
label: mgkit_fasta-utils
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/frubino/mgkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit_fasta-utils.out
