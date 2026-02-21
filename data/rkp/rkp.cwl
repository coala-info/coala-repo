cwlVersion: v1.2
class: CommandLineTool
baseCommand: rkp
label: rkp
doc: "Read Kmer Processor (Note: The provided text is a container build error log
  and does not contain CLI help information)\n\nTool homepage: https://gitlab.com/microbial_genomics/relative-kmer-project"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rkp:0.1.0--py_0
stdout: rkp.out
