cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle convert
label: eagle_convert
doc: "Convert VCF files to other formats.\n\nTool homepage: https://bitbucket.org/christopherschroeder/eagle"
inputs:
  - id: input
    type: File
    doc: the input in vcf format
    inputBinding:
      position: 1
  - id: outdir
    type: Directory
    doc: the output directory
    inputBinding:
      position: 2
  - id: ref
    type:
      - 'null'
      - File
    doc: the reference in fasta format to extract a variant motifs information
    inputBinding:
      position: 103
      prefix: --ref
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: limit the output creation to these samples
    inputBinding:
      position: 103
      prefix: --samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
stdout: eagle_convert.out
