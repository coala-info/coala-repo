cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapcloser
label: gapcloser_tgsgapcloser
doc: "A tool for closing gaps in genome assemblies (Note: The provided text contains
  container runtime error messages rather than help documentation).\n\nTool homepage:
  https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gapcloser:v1.12-r6_cv3
stdout: gapcloser_tgsgapcloser.out
