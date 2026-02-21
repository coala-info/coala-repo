cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer_yak-count
label: kmer_yak-count
doc: "A tool for k-mer counting (Note: The provided input text contains system error
  messages regarding container execution and does not include the actual help documentation
  or usage instructions).\n\nTool homepage: https://github.com/lh3/kmer-cnt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kmer:v020150903r2013-6-deb_cv1
stdout: kmer_yak-count.out
