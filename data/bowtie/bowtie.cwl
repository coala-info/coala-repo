cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie
label: bowtie
doc: "An ultrafast, memory-efficient short read aligner (Note: The provided text contains
  system error messages rather than help text, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/BenLangmead/bowtie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bowtie:1.3.1--py312hf8dbd9f_10
stdout: bowtie.out
