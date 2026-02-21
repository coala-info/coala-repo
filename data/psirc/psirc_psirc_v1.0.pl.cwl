cwlVersion: v1.2
class: CommandLineTool
baseCommand: psirc_psirc_v1.0.pl
label: psirc_psirc_v1.0.pl
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs (Singularity/Apptainer) and a fatal error message regarding
  an OCI image fetch failure.\n\nTool homepage: https://github.com/nictru/psirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
stdout: psirc_psirc_v1.0.pl.out
