cwlVersion: v1.2
class: CommandLineTool
baseCommand: superfocus
label: super-focus_superfocus
doc: "Subsystems Profile by Database Shuffling (SUPER-FOCUS) is a tool for agile and
  accurate functional profiling of shotgun metagenomic data.\n\nTool homepage: https://edwards.sdsu.edu/SUPERFOCUS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/super-focus:1.6--pyhdfd78af_1
stdout: super-focus_superfocus.out
