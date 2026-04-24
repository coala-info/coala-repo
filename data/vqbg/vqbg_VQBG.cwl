cwlVersion: v1.2
class: CommandLineTool
baseCommand: Assemble
label: vqbg_VQBG
doc: "Assemble reads into contigs\n\nTool homepage: https://github.com/qdu-bioinfo/VQBG"
inputs:
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: input reads file is in fasta format.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq_format
    type:
      - 'null'
      - boolean
    doc: input reads file is in fastq format.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of kmer
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: output_filename
    type:
      - 'null'
      - string
    doc: Name of the output file
    inputBinding:
      position: 101
      prefix: --output_filename
  - id: reads_filename
    type: string
    doc: the name of the file containing reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: trunk_filename
    type:
      - 'null'
      - string
    doc: Name of the trunk file.
    inputBinding:
      position: 101
      prefix: --trunk_filename
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vqbg:1.0.2--h884bc47_0
stdout: vqbg_VQBG.out
