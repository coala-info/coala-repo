cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquamis_aquamis_setup.sh
label: aquamis_aquamis_setup.sh
doc: "Setup script for AQUAMIS (Assembly-based QUality Assessment for Microbial Isolate
  Sequencing). Note: The provided text is an execution error log and does not contain
  usage instructions or argument definitions.\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/AQUAMIS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquamis:1.4.0--hdfd78af_0
stdout: aquamis_aquamis_setup.sh.out
