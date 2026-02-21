cwlVersion: v1.2
class: CommandLineTool
baseCommand: getorganelle_get_organelle_from_reads.py
label: getorganelle_get_organelle_from_reads.py
doc: "A tool for assembling organelle genomes from genomic reads.\n\nTool homepage:
  http://github.com/Kinggerm/GetOrganelle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_get_organelle_from_reads.py.out
