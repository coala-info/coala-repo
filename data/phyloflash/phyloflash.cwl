cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloflash
label: phyloflash
doc: "The provided text does not contain help information or documentation for phyloflash;
  it contains system error messages regarding a lack of disk space during a container
  image pull.\n\nTool homepage: https://github.com/HRGV/phyloFlash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_1
stdout: phyloflash.out
