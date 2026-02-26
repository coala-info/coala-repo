cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psap
  - annotate
label: psap_annotate
doc: "Annotate peptide fasta files with LLPS labels and store as a data frame\n\n\
  Tool homepage: https://github.com/vanheeringen-lab/psap"
inputs:
  - id: fasta
    type: File
    doc: Path to peptide fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: labels
    type:
      - 'null'
      - File
    doc: .txt file with llps uniprot ids (positive training labels)
    inputBinding:
      position: 101
      prefix: --labels
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory to store annotated data frame in .csv format
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
