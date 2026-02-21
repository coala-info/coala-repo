cwlVersion: v1.2
class: CommandLineTool
baseCommand: egglib
label: egglib
doc: "EggLib is a software package for evolutionary genetics and genomics. (Note:
  The provided text is a container runtime error log and does not contain CLI help
  information.)\n\nTool homepage: http://mycor.nancy.inra.fr/egglib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/egglib:3.6.0--py310h9b84884_0
stdout: egglib.out
