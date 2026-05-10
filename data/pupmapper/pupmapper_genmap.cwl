cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pupmapper
  - genmap
label: pupmapper_genmap
doc: "Generate k-mer mappability values using Genmap (indexing and mapping steps)\n\
  \nTool homepage: https://github.com/maxgmarin/pupmapper"
inputs:
  - id: errors
    type: int
    doc: Number of allowed mismatches (hamming distance) in k-mer mapping step.
    inputBinding:
      position: 101
      prefix: --errors
  - id: in_genome_fa
    type: File
    doc: Input genome fasta file (.fasta)
    inputBinding:
      position: 101
      prefix: --in_genome_fa
  - id: kmer_len
    type: int
    doc: k-mer length (bp) used to generate the k-mer mappability values
    inputBinding:
      position: 101
      prefix: --kmer_len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output additional messages during processing. Useful for 
      troubleshooting.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: Directory for all outputs of k-mer mappability processing w/ Genmap 
      (indexing and mapping steps)
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pupmapper:0.2.0--pyhdfd78af_0
