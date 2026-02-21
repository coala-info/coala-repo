cwlVersion: v1.2
class: CommandLineTool
baseCommand: express
label: express
doc: "eXpress is a software tool for quantifying the abundance of sets of sequences
  (e.g. transcripts or alleles) from sampled subsequences (e.g. RNA-seq reads).\n\n
  Tool homepage: https://github.com/expressjs/express"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/express:1.5.1--h7d875b9_3
stdout: express.out
