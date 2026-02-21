cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimmomatic
label: trimmomatic_trimmomatic.jar
doc: "Trimmomatic is a flexible read trimming tool for Illumina NGS data. Note: The
  provided text contains a fatal error regarding container extraction ('no space left
  on device') and does not contain the actual help text or argument definitions.\n
  \nTool homepage: https://www.plabipd.de/trimmomatic_main.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimmomatic:0.40--hdfd78af_0
stdout: trimmomatic_trimmomatic.jar.out
