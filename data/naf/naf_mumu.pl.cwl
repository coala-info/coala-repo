cwlVersion: v1.2
class: CommandLineTool
baseCommand: naf_mumu.pl
label: naf_mumu.pl
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/KirillKryukov/naf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naf:1.3.0--h7b50bb2_5
stdout: naf_mumu.pl.out
