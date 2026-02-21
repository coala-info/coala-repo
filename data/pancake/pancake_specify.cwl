cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - specify
label: pancake_specify
doc: "Specify or modify chromosome information in a PanCake Data Object File\n\nTool
  homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
    doc: name(s) of respective chromosome(s)
    inputBinding:
      position: 101
      prefix: --chrom
  - id: delete
    type:
      - 'null'
      - type: array
        items: string
    doc: chromosome names to delete
    inputBinding:
      position: 101
      prefix: --delete
  - id: genome
    type:
      - 'null'
      - string
    doc: name of genome CHROM belongs to
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_file
    type:
      - 'null'
      - File
    doc: input file containing mapping of chromosomes to genomes and additional chromosome
      names
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: name
    type:
      - 'null'
      - string
    doc: new name of specified chromosome, this will become the chromosome's name
      in incidental output files
    inputBinding:
      position: 101
      prefix: --name
  - id: panfile
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 101
      prefix: --panfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
stdout: pancake_specify.out
