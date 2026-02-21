cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh
label: machina_pmh
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh.out
