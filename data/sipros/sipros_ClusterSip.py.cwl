cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_ClusterSip.py
label: sipros_ClusterSip.py
doc: "Note: The provided text contains system logs and a fatal error message from
  a container runtime (Apptainer/Singularity) rather than the tool's help documentation.
  No arguments or descriptions could be extracted from the input.\n\nTool homepage:
  https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_ClusterSip.py.out
