cwlVersion: v1.2
class: CommandLineTool
baseCommand: somaticseq_somaticseq_parallel.py
label: somaticseq_somaticseq_parallel.py
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: http://bioinform.github.io/somaticseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
stdout: somaticseq_somaticseq_parallel.py.out
