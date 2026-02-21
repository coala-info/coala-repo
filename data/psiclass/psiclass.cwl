cwlVersion: v1.2
class: CommandLineTool
baseCommand: psiclass
label: psiclass
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container image
  build failure.\n\nTool homepage: https://github.com/splicebox/PsiCLASS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
stdout: psiclass.out
