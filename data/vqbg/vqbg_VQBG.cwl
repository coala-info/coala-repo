cwlVersion: v1.2
class: CommandLineTool
baseCommand: VQBG
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
  - id: reads_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: --reads
    doc: the file containing reads (give forward and reverse files for paired reads)
    inputBinding:
      position: 101
  - id: trunk_filename
    type:
      - 'null'
      - File
    doc: Name of the trunk file (assembled contigs, for example from FC-Virus).
    inputBinding:
      position: 101
      prefix: --trunk_filename
outputs:
  - id: assembled_paths
    type:
      - 'null'
      - File
    doc: Assembled paths (default paths.fasta)
    outputBinding:
      glob: "$(inputs.output_filename ? inputs.output_filename : 'paths.fasta')"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vqbg:1.0.2--h884bc47_0
requirements:
  - class: InlineJavascriptRequirement
stdout: vqbg_VQBG.out
