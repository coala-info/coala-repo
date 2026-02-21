cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp_PPSSPPHeadless
label: pp_PPSSPPHeadless
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/hrydgard/ppsspp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp:1.6.5--py27_0
stdout: pp_PPSSPPHeadless.out
