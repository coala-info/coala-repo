cwlVersion: v1.2
class: CommandLineTool
baseCommand: shovill-se
label: shovill-se
doc: "De novo assembly pipeline for Illumina single-end reads\n\nTool homepage: https://github.com/rpetit3/shovill"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: 'Assembler: spades skesa megahit velvet'
    default: spades
    inputBinding:
      position: 101
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (0=ALL)
    default: 8
    inputBinding:
      position: 101
  - id: depth
    type:
      - 'null'
      - int
    doc: Sub-sample --R1/--R2 to this depth. Disable with --depth 0
    default: 150
    inputBinding:
      position: 101
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwite of existing output folder
    default: OFF
    inputBinding:
      position: 101
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated genome size eg. 3.2M <blank=AUTODETECT>
    default: ''
    inputBinding:
      position: 101
  - id: keepfiles
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    default: OFF
    inputBinding:
      position: 101
  - id: kmers
    type:
      - 'null'
      - string
    doc: K-mers to use <blank=AUTO>
    default: ''
    inputBinding:
      position: 101
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum contig coverage <0=AUTO>
    default: 2
    inputBinding:
      position: 101
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum contig length <0=AUTO>
    default: 0
    inputBinding:
      position: 101
  - id: namefmt
    type:
      - 'null'
      - string
    doc: Format of contig FASTA IDs in 'printf' style
    default: contig%05d
    inputBinding:
      position: 101
  - id: nocorr
    type:
      - 'null'
      - boolean
    doc: Disable post-assembly correction
    default: OFF
    inputBinding:
      position: 101
  - id: noreadcorr
    type:
      - 'null'
      - boolean
    doc: Disable read error correction
    default: OFF
    inputBinding:
      position: 101
  - id: opts
    type:
      - 'null'
      - string
    doc: "Extra assembler options in quotes eg. spades: '--sc' ..."
    default: ''
    inputBinding:
      position: 101
  - id: outdir
    type: Directory
    doc: Output folder
    inputBinding:
      position: 101
  - id: ram
    type:
      - 'null'
      - float
    doc: Try to keep RAM usage below this many GB
    default: 16
    inputBinding:
      position: 101
  - id: single_end_reads
    type: File
    doc: Single-end reads
    inputBinding:
      position: 101
      prefix: --single
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Fast temporary directory
    default: ''
    inputBinding:
      position: 101
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Enable adaptor trimming
    default: OFF
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shovill-se:1.1.0se--hdfd78af_2
stdout: shovill-se.out
