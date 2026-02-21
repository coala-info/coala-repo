cwlVersion: v1.2
class: CommandLineTool
baseCommand: phispy
label: phispy
doc: "PhiSpy is a tool for identifying prophages in bacterial genomes. (Note: The
  provided help text contains only container runtime error messages and no usage information;
  arguments could not be extracted from the input.)\n\nTool homepage: https://github.com/linsalrob/PhiSpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phispy:4.2.21--py310h0dbaff4_2
stdout: phispy.out
