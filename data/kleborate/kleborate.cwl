cwlVersion: v1.2
class: CommandLineTool
baseCommand: kleborate
label: kleborate
doc: "Kleborate is a tool to screen Klebsiella pneumoniae genome assemblies for MLST,
  sub-species, and major virulence and resistance determinants.\n\nTool homepage:
  https://github.com/katholt/Kleborate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kleborate:3.2.4--pyhdfd78af_0
stdout: kleborate.out
