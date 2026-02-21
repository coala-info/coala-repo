cwlVersion: v1.2
class: CommandLineTool
baseCommand: psiclass_grader
label: psiclass_grader
doc: "The provided text does not contain help information for psiclass_grader; it
  contains error logs from a container build process. No arguments or tool descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/splicebox/PsiCLASS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
stdout: psiclass_grader.out
