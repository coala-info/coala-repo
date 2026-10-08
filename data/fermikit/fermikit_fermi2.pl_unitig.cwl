cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi2.pl
  - unitig
label: fermikit_fermi2.pl_unitig
doc: "Generate a Makefile for unitig assembly (error correction, filtering, FM-index,\
  \ assemble, simplify). Run the Makefile with make to get PREFIX.mag.gz.\n\nTool\
  \ homepage: https://github.com/lh3/fermikit"
inputs:
  - id: in_fq
    type: File
    doc: Input reads in FASTQ format (plain or gzip-compressed)
    inputBinding:
      position: 201
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: genome_size
    type:
      - 'null'
      - string
    doc: approximate genome size
    inputBinding:
      position: 101
      prefix: -s
  - id: two_pass_error_correction
    type:
      - 'null'
      - boolean
    doc: 2-pass error correction
    inputBinding:
      position: 101
      prefix: '-2'
  - id: read_length
    type:
      - 'null'
      - int
    doc: primary read length
    inputBinding:
      position: 101
      prefix: -l
  - id: trim_kmer
    type:
      - 'null'
      - int
    doc: use INT-mer for post-trimming/filtering
    inputBinding:
      position: 101
      prefix: -T
  - id: min_overlap_unitig
    type:
      - 'null'
      - int
    doc: min overlap length during unitig construction
    inputBinding:
      position: 101
      prefix: -k
  - id: min_overlap_cleaning
    type:
      - 'null'
      - int
    doc: min overlap length during graph cleaning
    inputBinding:
      position: 101
      prefix: -o
  - id: min_overlap_merging
    type:
      - 'null'
      - int
    doc: min overlap length for unambiguous merging
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: no_error_correction
    type:
      - 'null'
      - boolean
    doc: don't apply error correction
    inputBinding:
      position: 101
      prefix: -E
outputs:
  - id: makefile
    type: stdout
    doc: Makefile for unitig assembly
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_fermi2.pl_unitig.out
