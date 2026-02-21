cwlVersion: v1.2
class: CommandLineTool
baseCommand: circrna_finder_runStar.pl
label: circrna_finder_runStar.pl
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a 'no space left on device' failure during a
  container build process.\n\nTool homepage: https://github.com/orzechoj/circRNA_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circrna_finder:1.2--pl5321hdfd78af_1
stdout: circrna_finder_runStar.pl.out
