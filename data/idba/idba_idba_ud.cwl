cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_ud
label: idba_idba_ud
doc: "IDBA-UD - Iterative de Bruijn Graph Assembler for sequencing data with highly\n\
  uneven depth. Reads must be FASTA (convert FASTQ with fq2fa).\n\nTool homepage:
  https://github.com/loneknightpy/idba"
inputs:
  - id: read
    type: File
    doc: fasta read file (<=600)
    inputBinding:
      prefix: --read
  - id: read_level_2
    type: ['null', File]
    doc: paired-end reads fasta for second level scaffolds
    inputBinding:
      prefix: --read_level_2
  - id: read_level_3
    type: ['null', File]
    doc: paired-end reads fasta for third level scaffolds
    inputBinding:
      prefix: --read_level_3
  - id: read_level_4
    type: ['null', File]
    doc: paired-end reads fasta for fourth level scaffolds
    inputBinding:
      prefix: --read_level_4
  - id: read_level_5
    type: ['null', File]
    doc: paired-end reads fasta for fifth level scaffolds
    inputBinding:
      prefix: --read_level_5
  - id: long_read
    type: ['null', File]
    doc: fasta long read file (>600)
    inputBinding:
      prefix: --long_read
  - id: out_dir
    type: ['null', string]
    default: out
    doc: output directory
    inputBinding:
      prefix: --out
  - id: mink
    type: ['null', int]
    doc: minimum k value (<=312)
    inputBinding:
      prefix: --mink
  - id: maxk
    type: ['null', int]
    doc: maximum k value (<=312)
    inputBinding:
      prefix: --maxk
  - id: step
    type: ['null', int]
    doc: increment of k-mer of each iteration
    inputBinding:
      prefix: --step
  - id: inner_mink
    type: ['null', int]
    doc: inner minimum k value
    inputBinding:
      prefix: --inner_mink
  - id: inner_step
    type: ['null', int]
    doc: inner increment of k-mer
    inputBinding:
      prefix: --inner_step
  - id: prefix
    type: ['null', int]
    doc: prefix length used to build sub k-mer table
    inputBinding:
      prefix: --prefix
  - id: min_count
    type: ['null', int]
    doc: minimum multiplicity for filtering k-mer when building the graph
    inputBinding:
      prefix: --min_count
  - id: min_support
    type: ['null', int]
    doc: minimum supoort in each iteration
    inputBinding:
      prefix: --min_support
  - id: num_threads
    type: ['null', int]
    doc: number of threads
    inputBinding:
      prefix: --num_threads
  - id: seed_kmer
    type: ['null', int]
    doc: seed kmer size for alignment
    inputBinding:
      prefix: --seed_kmer
  - id: min_contig
    type: ['null', int]
    doc: minimum size of contig
    inputBinding:
      prefix: --min_contig
  - id: similar
    type: ['null', double]
    doc: similarity for alignment
    inputBinding:
      prefix: --similar
  - id: max_mismatch
    type: ['null', int]
    doc: max mismatch of error correction
    inputBinding:
      prefix: --max_mismatch
  - id: min_pairs
    type: ['null', int]
    doc: minimum number of pairs
    inputBinding:
      prefix: --min_pairs
  - id: no_bubble
    type: ['null', boolean]
    doc: do not merge bubble
    inputBinding:
      prefix: --no_bubble
  - id: no_local
    type: ['null', boolean]
    doc: do not use local assembly
    inputBinding:
      prefix: --no_local
  - id: no_coverage
    type: ['null', boolean]
    doc: do not iterate on coverage
    inputBinding:
      prefix: --no_coverage
  - id: no_correct
    type: ['null', boolean]
    doc: do not do correction
    inputBinding:
      prefix: --no_correct
  - id: pre_correction
    type: ['null', boolean]
    doc: perform pre-correction before assembly
    inputBinding:
      prefix: --pre_correction
outputs:
  - id: out
    type: Directory
    doc: output directory with contig.fa, scaffold.fa and graph files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idba:1.1.3--1
