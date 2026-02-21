cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerfinder.py
label: kmerfinder_kmerfinder.py
doc: "KmerFinder is a tool for identifying bacterial species in a sample using k-mer
  genomic information.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kmerfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerfinder:3.0.2--hdfd78af_0
stdout: kmerfinder_kmerfinder.py.out
