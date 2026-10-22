cwlVersion: v1.2
class: CommandLineTool
baseCommand: map_back
label: seer_map_back
doc: "map_back: context of significant kmers\n\nTool homepage: https://github.com/johnlees/seer"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.reference_fastas)
inputs:
  - id: kmers
    type: File
    doc: "Seer kmer output file"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: references
    type: File
    doc: "File with tab separated reference name and fasta file (the fasta files must be given in reference_fastas so they are staged beside the working directory)"
    inputBinding:
      position: 1
      prefix: --references
  - id: reference_fastas
    type: File[]
    doc: "Fasta files named in the references file, staged in the working directory"
  - id: threads
    type: ['null', int]
    doc: "Number of threads. Suggested: 20"
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_map_back.out
