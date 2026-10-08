cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pileups_to_freq_table.py
label: desman_pileups_to_freq_table.py
doc: "Convert per-sample samtools mpileup files into a DESMAN variant frequency
  table (Contig, Position, then A,C,G,T counts per sample, base quality >= 20)
  holding only the sites where at least two different bases are seen. Needs
  at least two pileup files.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: contigs
    type: File
    doc: FASTA file of the contigs the reads were mapped to (gives the contig 
      order)
    inputBinding:
      position: 10
  - id: pileups
    type: File[]
    doc: samtools mpileup files, one per sample, in contig order
    inputBinding:
      position: 11
  - id: output_name
    type: string
    doc: Output frequency table
    default: freq_table.csv
    inputBinding:
      position: 12
outputs:
  - id: freq_table
    type: File
    doc: Variant site frequency table (CSV)
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
