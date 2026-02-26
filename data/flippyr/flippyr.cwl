cwlVersion: v1.2
class: CommandLineTool
baseCommand: flippyr
label: flippyr
doc: "A simple python script to search for allele switches, strand flips, multiallelic
  sites, ambiguous sites, and indels. The output is in the form of a .bim-like table
  and a log file.\n\nTool homepage: https://github.com/BEFH/flippyr"
inputs:
  - id: fasta
    type: File
    doc: Fasta file containing all chromosomes in the plink fileset
    inputBinding:
      position: 1
  - id: bim
    type: File
    doc: .bim file from binary plink fileset.
    inputBinding:
      position: 2
  - id: keep_indels
    type:
      - 'null'
      - boolean
    doc: Do not delete insertions/deletions.
    inputBinding:
      position: 103
      prefix: --keepIndels
  - id: keep_multiallelic
    type:
      - 'null'
      - boolean
    doc: Do not delete multiallelic sites.
    inputBinding:
      position: 103
      prefix: --keepMultiallelic
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Change output file prefix.
    inputBinding:
      position: 103
      prefix: --outputPrefix
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: Change output file suffix for plink file.
    inputBinding:
      position: 103
      prefix: --outputSuffix
  - id: plink
    type:
      - 'null'
      - boolean
    doc: Run the plink command.
    inputBinding:
      position: 103
      prefix: --plink
  - id: plink_memory
    type:
      - 'null'
      - string
    doc: Set the memory limit for plink.
    inputBinding:
      position: 103
      prefix: --plinkMem
  - id: rebuild_fasta
    type:
      - 'null'
      - boolean
    doc: Rebuild the fasta index if out of date.
    inputBinding:
      position: 103
      prefix: --rebuildFasta
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Supress output to stdout.
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flippyr:0.6.1--pyh7e72e81_0
stdout: flippyr.out
