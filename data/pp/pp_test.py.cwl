cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp_test.py
label: pp_test.py
doc: "The provided text does not contain help information or usage instructions for
  pp_test.py. It contains log messages from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build a SIF image from a Docker URI.\n\nTool homepage:
  https://github.com/hrydgard/ppsspp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp:1.6.5--py27_0
stdout: pp_test.py.out
