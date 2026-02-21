cwlVersion: v1.2
class: CommandLineTool
baseCommand: cured_CURED_Main.py
label: cured_CURED_Main.py
doc: "The provided text does not contain help information or argument definitions.
  It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the OCI image due to insufficient disk
  space.\n\nTool homepage: https://github.com/microbialARC/CURED"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cured:1.05--hdfd78af_0
stdout: cured_CURED_Main.py.out
