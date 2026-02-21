cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesm_git-fleximod
label: cesm_git-fleximod
doc: "The provided text does not contain help information or a description for the
  tool; it is a system error log regarding a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/ESCOMP/cesm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesm:2.1.3--py39hd40aa7f_3
stdout: cesm_git-fleximod.out
