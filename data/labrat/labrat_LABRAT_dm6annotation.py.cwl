cwlVersion: v1.2
class: CommandLineTool
baseCommand: labrat_LABRAT_dm6annotation.py
label: labrat_LABRAT_dm6annotation.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a 'no space left on device' failure during image conversion.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRAT_dm6annotation.py.out
