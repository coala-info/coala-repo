cwlVersion: v1.2
class: CommandLineTool
baseCommand: haslr.py
label: haslr_haslr.py
doc: "A tool for long-read-first assembly.\n\nTool homepage: https://github.com/vpc-ccg/haslr"
inputs:
  - id: aln_block
    type:
      - 'null'
      - int
    doc: minimum length of alignment block
    default: 500
    inputBinding:
      position: 101
      prefix: --aln-block
  - id: aln_sim
    type:
      - 'null'
      - float
    doc: minimum alignment similarity
    default: 0.85
    inputBinding:
      position: 101
      prefix: --aln-sim
  - id: cov_lr
    type:
      - 'null'
      - int
    doc: amount of long read coverage to use for assembly
    default: 25
    inputBinding:
      position: 101
      prefix: --cov-lr
  - id: edge_sup
    type:
      - 'null'
      - int
    doc: minimum number of long read supporting each edge
    default: 3
    inputBinding:
      position: 101
      prefix: --edge-sup
  - id: genome_size
    type: string
    doc: estimated genome size; accepted suffixes are k,m,g
    inputBinding:
      position: 101
      prefix: --genome
  - id: long_read_file
    type: File
    doc: long read file
    inputBinding:
      position: 101
      prefix: --long
  - id: long_read_type
    type: string
    doc: type of long reads chosen from {pacbio,nanopore}
    inputBinding:
      position: 101
      prefix: --type
  - id: minia_asm
    type:
      - 'null'
      - string
    doc: type of minia assembly chosen from {contigs,unitigs}
    default: contigs
    inputBinding:
      position: 101
      prefix: --minia-asm
  - id: minia_kmer
    type:
      - 'null'
      - int
    doc: kmer size used by minia
    default: 49
    inputBinding:
      position: 101
      prefix: --minia-kmer
  - id: minia_solid
    type:
      - 'null'
      - int
    doc: minimum kmer abundance used by minia
    default: 3
    inputBinding:
      position: 101
      prefix: --minia-solid
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out
  - id: short_read_files
    type:
      type: array
      items: File
    doc: short read file
    inputBinding:
      position: 101
      prefix: --short
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haslr:0.8a1--py310h275bdba_6
stdout: haslr_haslr.py.out
