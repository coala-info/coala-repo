cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer_kc-c4
label: kmer_kc-c4
doc: "A tool from the kmer suite (Note: The provided help text contains only system
  error messages regarding container image retrieval and does not list specific usage
  instructions or arguments).\n\nTool homepage: https://github.com/lh3/kmer-cnt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kmer:v020150903r2013-6-deb_cv1
stdout: kmer_kc-c4.out
