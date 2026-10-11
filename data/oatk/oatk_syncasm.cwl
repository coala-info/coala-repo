cwlVersion: v1.2
class: CommandLineTool
baseCommand: syncasm
label: oatk_syncasm
doc: "De novo HiFi read assembler using a sparse de Bruijn graph built from closed syncmers.\n\nTool homepage: https://github.com/c-zhou/oatk"
inputs:
  - id: target_fasta
    type:
      type: array
      items: File
    doc: Input HiFi reads in FASTA or FASTQ format, plain or gzipped.
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size.
    inputBinding:
      position: 102
      prefix: -k
  - id: smer_size
    type:
      - 'null'
      - int
    doc: Smer size (no larger than 31).
    inputBinding:
      position: 102
      prefix: -s
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: Minimum kmer coverage.
    inputBinding:
      position: 102
      prefix: -c
  - id: min_arc_coverage
    type:
      - 'null'
      - float
    doc: Minimum arc coverage.
    inputBinding:
      position: 102
      prefix: -a
  - id: max_data_amount
    type:
      - 'null'
      - string
    doc: Maximum amount of data to use; suffix k/m/g recognized.
    inputBinding:
      position: 102
      prefix: -D
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 102
      prefix: -t
  - id: max_bubble
    type:
      - 'null'
      - int
    doc: Maximum bubble size for assembly graph clean.
    inputBinding:
      position: 102
      prefix: --max-bubble
  - id: max_tip
    type:
      - 'null'
      - int
    doc: Maximum tip size for assembly graph clean.
    inputBinding:
      position: 102
      prefix: --max-tip
  - id: weak_cross
    type:
      - 'null'
      - float
    doc: Maximum relative edge coverage for weak crosslink clean.
    inputBinding:
      position: 102
      prefix: --weak-cross
  - id: unzip_round
    type:
      - 'null'
      - int
    doc: Maximum round of assembly graph unzipping.
    inputBinding:
      position: 102
      prefix: --unzip-round
  - id: no_read_ec
    type:
      - 'null'
      - boolean
    doc: Do not do read error correction.
    inputBinding:
      position: 102
      prefix: --no-read-ec
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level.
    inputBinding:
      position: 102
      prefix: -v
  - id: output_prefix_path
    type: string
    doc: prefix of output files
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: Assembly graph files written with the output prefix (for example prefix.utg.final.gfa)
    outputBinding:
      glob: $(inputs.output_prefix_path)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0--h577a1d6_1
