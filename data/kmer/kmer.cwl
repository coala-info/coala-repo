cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer
label: kmer
doc: "A tool for k-mer analysis (Note: The provided help text contains only system
  error messages regarding container execution and does not list specific tool arguments).\n
  \nTool homepage: https://github.com/lh3/kmer-cnt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kmer:v020150903r2013-6-deb_cv1
stdout: kmer.out
