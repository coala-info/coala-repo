cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-core
label: nf-core
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help documentation or command-line argument definitions.\n\n
  Tool homepage: http://nf-co.re/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
stdout: nf-core.out
