cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk_flkfreq
label: hapflk_flkfreq
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/BertrandServin/hapflk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk_flkfreq.out
