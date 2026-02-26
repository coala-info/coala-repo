cwlVersion: v1.2
class: CommandLineTool
baseCommand: genoflu_genoflu.py
label: genoflu_genoflu.py
doc: "FASTA files with formated headers are used to build BLAST database. The input
  FASTA is BLASTed against the database. The top hit for each segment is used to determine
  the genotype. The genotype is determined by cross-referencing the top hits to a
  excel file. If the top hit for each segment matches a genotype, then the genotype
  is assigned. If the top hit for each segment does not match a genotype, then the
  genotype is not assigned. If the top hit for each segment matches a genotype, but
  the genotype is not complete (i.e. only 7 segments match), then the genotype is
  not assigned. If the top hit for each segment matches a genotype, and the genotype
  is complete (i.e. all 8 segments match), then the genotype is assigned.\n\nTool
  homepage: https://github.com/USDA-VS/GenoFLU"
inputs:
  - id: cross_reference
    type:
      - 'null'
      - File
    doc: Excel file to cross-reference BLAST findings and identification to 
      genotyping results. Default genoflu/dependencies. 9 column Excel file, 
      first column Genotype, followed by 8 columns for each segment and what 
      those calls are for that genotype.
    inputBinding:
      position: 101
      prefix: --cross_reference
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep temp file
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: Assembled FASTA
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fasta_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing FASTAs to BLAST against. Headers must follow 
      specific format.
    inputBinding:
      position: 101
      prefix: --FASTA_dir
  - id: pident_threshold
    type:
      - 'null'
      - float
    doc: BLAST result greater than or equal to this number gets genotype calls
    inputBinding:
      position: 101
      prefix: --pident_threshold
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force output files to this sample name
    inputBinding:
      position: 101
      prefix: --sample_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genoflu:1.06--hdfd78af_0
stdout: genoflu_genoflu.py.out
