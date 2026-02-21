cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzip_main_text.py
label: gzip_main_text.py
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build a SIF image for gzip due to insufficient disk space.\n\nTool homepage:
  https://github.com/bazingagin/npc_gzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzip:1.11
stdout: gzip_main_text.py.out
