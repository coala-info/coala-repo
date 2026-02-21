cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgkit_snp_parser
label: mgkit_snp_parser
doc: "The provided text does not contain help information for mgkit_snp_parser; it
  contains system error messages regarding a container runtime (Apptainer/Singularity)
  failure due to lack of disk space.\n\nTool homepage: https://github.com/frubino/mgkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit_snp_parser.out
