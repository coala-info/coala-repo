cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_subasm
label: idba_subasm
doc: "Iterative De Bruijn Graph Assembler for assembling sub-reads.\n\nTool homepage:
  https://github.com/abishara/idba"
inputs:
  - id: maxk
    type:
      - 'null'
      - int
    doc: maximum k value
    inputBinding:
      position: 101
      prefix: --maxk
  - id: min_contig
    type:
      - 'null'
      - int
    doc: minimum size of contig
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: min_count
    type:
      - 'null'
      - int
    doc: minimum multiplicity for filtering k-mer
    inputBinding:
      position: 101
      prefix: --min_count
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum support in each iteration
    inputBinding:
      position: 101
      prefix: --min_support
  - id: mink
    type:
      - 'null'
      - int
    doc: minimum k value
    inputBinding:
      position: 101
      prefix: --mink
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: prefix
    type:
      - 'null'
      - int
    doc: prefix length used to build hash table
    inputBinding:
      position: 101
      prefix: --prefix
  - id: read
    type: File
    doc: fasta read file
    inputBinding:
      position: 101
      prefix: --read
  - id: seed_kmer
    type:
      - 'null'
      - int
    doc: seed kmer size for alignment
    inputBinding:
      position: 101
      prefix: --seed_kmer
  - id: step
    type:
      - 'null'
      - int
    doc: increment of k-mer of each iteration
    inputBinding:
      position: 101
      prefix: --step
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 102
      prefix: --out
  - id: read_level_2
    type: ['null', File]
    doc: paired-end reads fasta for second level scaffolds
    inputBinding:
      position: 101
      prefix: --read_level_2
  - id: read_level_3
    type: ['null', File]
    doc: paired-end reads fasta for third level scaffolds
    inputBinding:
      position: 101
      prefix: --read_level_3
  - id: read_level_4
    type: ['null', File]
    doc: paired-end reads fasta for fourth level scaffolds
    inputBinding:
      position: 101
      prefix: --read_level_4
  - id: read_level_5
    type: ['null', File]
    doc: paired-end reads fasta for fifth level scaffolds
    inputBinding:
      position: 101
      prefix: --read_level_5
  - id: long_read
    type: ['null', File]
    doc: fasta long read file (>512)
    inputBinding:
      position: 101
      prefix: --long_read
  - id: inner_mink
    type: ['null', int]
    doc: inner minimum k value
    inputBinding:
      position: 101
      prefix: --inner_mink
  - id: inner_step
    type: ['null', int]
    doc: inner increment of k-mer
    inputBinding:
      position: 101
      prefix: --inner_step
  - id: similar
    type: ['null', double]
    doc: similarity for alignment
    inputBinding:
      position: 101
      prefix: --similar
  - id: max_mismatch
    type: ['null', int]
    doc: max mismatch of error correction
    inputBinding:
      position: 101
      prefix: --max_mismatch
  - id: min_pairs
    type: ['null', int]
    doc: minimum number of pairs
    inputBinding:
      position: 101
      prefix: --min_pairs
  - id: no_bubble
    type: ['null', boolean]
    doc: do not merge bubble
    inputBinding:
      position: 101
      prefix: --no_bubble
  - id: no_local
    type: ['null', boolean]
    doc: do not use local assembly
    inputBinding:
      position: 101
      prefix: --no_local
  - id: no_coverage
    type: ['null', boolean]
    doc: do not iterate on coverage
    inputBinding:
      position: 101
      prefix: --no_coverage
  - id: no_correct
    type: ['null', boolean]
    doc: do not do correction
    inputBinding:
      position: 101
      prefix: --no_correct
  - id: pre_correction
    type: ['null', boolean]
    doc: perform pre-correction before assembly
    inputBinding:
      position: 101
      prefix: --pre_correction
  - id: seed_contig
    type: File
    doc: fasta seed contig file (required by the tool)
    inputBinding:
      position: 101
      prefix: --seed_contig
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idba_subasm:1.1.3a2--py311pl5321h8ddd9a4_9
