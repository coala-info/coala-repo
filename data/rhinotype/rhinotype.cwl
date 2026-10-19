cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhinotype
label: rhinotype
doc: "Rhinotype — a CLI tool for assigning rhinovirus genotypes based on VP1 or VP4/2
  genomic regions.\n\nTool homepage: https://github.com/omicscodeathon/rhinotype"
inputs:
  - id: input
    type: File
    doc: Path to user FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - string
    doc: 'Evolutionary model to use (default: p-distance). Options: p-distance, jc69,
      k2p, tn93'
    inputBinding:
      position: 101
      prefix: --model
  - id: region
    type: string
    doc: Genomic region (e.g., Vp1 or Vp4/2)
    inputBinding:
      position: 101
      prefix: --region
  - id: threads
    type:
      - 'null'
      - int
    doc: Select the number of threads mafft to use for alignment
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: The p-distance threshold for genotyping (e.g., 0.105).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: reports
    type:
      - 'null'
      - Directory
    doc: Directory with the genotype classification report (CSV)
    outputBinding:
      glob: reports
  - id: figures
    type:
      - 'null'
      - Directory
    doc: Directory with the SNP, tree, frequency and amino acid figures
    outputBinding:
      glob: figures
  - id: alignment
    type:
      - 'null'
      - File
    doc: MAFFT alignment of the query sequences and the prototype sequences
    outputBinding:
      glob: sequence_align.fasta
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhinotype:2.0.0--pyhdfd78af_0
stdout: rhinotype.out
