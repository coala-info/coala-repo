cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bowtie-build
label: bowtie_bowtie-build
doc: "The provided text contains system error messages related to disk space and container
  execution rather than the tool's help documentation. Bowtie-build is a tool for
  building index files from a set of DNA sequences.\n\nTool homepage: https://github.com/BenLangmead/bowtie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bowtie:1.3.1--py312hf8dbd9f_10
stdout: bowtie_bowtie-build.out
