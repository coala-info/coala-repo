cwlVersion: v1.2
class: CommandLineTool
baseCommand: merqury.sh
label: merqury_merqury.sh
doc: "Generates k-mer counts for read sets and assemblies to assess assembly quality.\n\
  \nTool homepage: https://github.com/marbl/merqury"
inputs:
  - id: read_db_meryl
    type: File
    doc: k-mer counts of the read set
    inputBinding:
      position: 1
  - id: mat_meryl
    type:
      - 'null'
      - File
    doc: k-mer counts of the maternal haplotype (ex. mat.hapmer.meryl)
    inputBinding:
      position: 2
  - id: pat_meryl
    type:
      - 'null'
      - File
    doc: k-mer counts of the paternal haplotype (ex. pat.hapmer.meryl)
    inputBinding:
      position: 3
  - id: asm1_fasta
    type: File
    doc: Assembly fasta file (ex. pri.fasta, hap1.fasta or maternal.fasta)
    inputBinding:
      position: 4
  - id: asm2_fasta
    type:
      - 'null'
      - File
    doc: Additional fasta file (ex. alt.fasta, hap2.fasta or paternal.fasta)
    inputBinding:
      position: 5
  - id: out
    type: string
    doc: Output prefix
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merqury:1.3--hdfd78af_4
stdout: merqury_merqury.sh.out
