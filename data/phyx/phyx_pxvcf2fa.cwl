cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxvcf2fa]
label: phyx_pxvcf2fa
doc: |-
  Convert vcf file to fasta.
  Currently only handles haploid data; phased data will come soon.
  Data can be read from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input vcf file"
    inputBinding:
      prefix: -s
  - id: uppercase
    type: ['null', boolean]
    doc: "export characters in uppercase"
    inputBinding:
      prefix: -u
  - id: out_file_path
    type: string
    doc: "output fasta sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "fasta alignment"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
