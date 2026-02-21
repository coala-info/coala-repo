cwlVersion: v1.2
class: CommandLineTool
baseCommand: freebayes_fasta_generate_regions.py
label: freebayes_fasta_generate_regions.py
doc: "A tool to generate genomic regions from a FASTA index file, typically used for
  parallelizing freebayes execution.\n\nTool homepage: https://github.com/freebayes/freebayes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freebayes:1.3.10--hbefcdb2_0
stdout: freebayes_fasta_generate_regions.py.out
