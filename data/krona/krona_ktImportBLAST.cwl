cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportBLAST
label: krona_ktImportBLAST
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/marbl/Krona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktImportBLAST.out
