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
    inputBinding:
      position: 101
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (0=ALL)
    inputBinding:
      position: 101
  - id: depth
    type:
      - 'null'
      - int
    doc: Sub-sample --R1/--R2 to this depth. Disable with --depth 0
    inputBinding:
      position: 101
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwite of existing output folder
    inputBinding:
      position: 101
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated genome size eg. 3.2M <blank=AUTODETECT>
    inputBinding:
      position: 101
  - id: keepfiles
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 101
  - id: kmers
    type:
      - 'null'
      - string
    doc: K-mers to use <blank=AUTO>
    inputBinding:
      position: 101
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum contig coverage <0=AUTO>
    inputBinding:
      position: 101
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum contig length <0=AUTO>
    inputBinding:
      position: 101
  - id: namefmt
    type:
      - 'null'
      - string
    doc: Format of contig FASTA IDs in 'printf' style
    inputBinding:
      position: 101
  - id: nocorr
    type:
      - 'null'
      - boolean
    doc: Disable post-assembly correction
    inputBinding:
      position: 101
  - id: noreadcorr
    type:
      - 'null'
      - boolean
    doc: Disable read error correction
    inputBinding:
      position: 101
  - id: opts
    type:
      - 'null'
      - string
    doc: "Extra assembler options in quotes eg. spades: '--sc' ..."
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
    inputBinding:
      position: 101
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Enable adaptor trimming
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
