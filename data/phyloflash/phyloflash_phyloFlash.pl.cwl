cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloFlash.pl
label: phyloflash_phyloFlash.pl
doc: "Runs the phyloFlash pipeline to assemble and annotate eukaryotic viral genomes
  from sequencing data.\n\nTool homepage: https://github.com/HRGV/phyloFlash"
inputs:
  - id: check_env
    type:
      - 'null'
      - boolean
    doc: Check environment setup
    inputBinding:
      position: 101
      prefix: -check_env
  - id: library_name
    type: string
    doc: Name of the library
    inputBinding:
      position: 101
      prefix: -lib
  - id: man
    type:
      - 'null'
      - boolean
    doc: Display man page
    inputBinding:
      position: 101
      prefix: -man
  - id: read1
    type: File
    doc: Path to the first FASTQ file (R1)
    inputBinding:
      position: 101
      prefix: -read1
  - id: read2
    type: File
    doc: Path to the second FASTQ file (R2)
    inputBinding:
      position: 101
      prefix: -read2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash.pl.out
