cwlVersion: v1.2
class: CommandLineTool
baseCommand: labrat_LABRAT_rn6annotation.py
label: labrat_LABRAT_rn6annotation.py
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRAT_rn6annotation.py.out
