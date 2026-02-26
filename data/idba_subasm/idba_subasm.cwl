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
    default: 100
    inputBinding:
      position: 101
      prefix: --maxk
  - id: min_contig
    type:
      - 'null'
      - int
    doc: minimum size of contig
    default: 200
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: min_count
    type:
      - 'null'
      - int
    doc: minimum multiplicity for filtering k-mer
    default: 2
    inputBinding:
      position: 101
      prefix: --min_count
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum support in each iteration
    default: 1
    inputBinding:
      position: 101
      prefix: --min_support
  - id: mink
    type:
      - 'null'
      - int
    doc: minimum k value
    default: 20
    inputBinding:
      position: 101
      prefix: --mink
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 0
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: prefix
    type:
      - 'null'
      - int
    doc: prefix length used to build hash table
    default: 10
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
    default: 30
    inputBinding:
      position: 101
      prefix: --seed_kmer
  - id: step
    type:
      - 'null'
      - int
    doc: increment of k-mer of each iteration
    default: 20
    inputBinding:
      position: 101
      prefix: --step
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
