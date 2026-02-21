cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp_unittest
label: pp_unittest
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log output from a container runtime (Apptainer/Singularity)
  build failure.\n\nTool homepage: https://github.com/hrydgard/ppsspp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp:1.6.5--py27_0
stdout: pp_unittest.out
