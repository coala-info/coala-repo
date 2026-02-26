cwlVersion: v1.2
class: CommandLineTool
baseCommand: shovill
label: shovill
doc: "De novo assembly pipeline for Illumina paired reads\n\nTool homepage: https://github.com/tseemann/shovill"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: 'Assembler: megahit skesa spades velvet'
    default: spades
    inputBinding:
      position: 101
      prefix: --assembler
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies are installed
    inputBinding:
      position: 101
      prefix: --check
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (0=ALL)
    default: 8
    inputBinding:
      position: 101
      prefix: --cpus
  - id: depth
    type:
      - 'null'
      - int
    doc: Sub-sample --R1/--R2 to this depth. Disable with --depth 0
    default: 150
    inputBinding:
      position: 101
      prefix: --depth
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwite of existing output folder
    default: OFF
    inputBinding:
      position: 101
      prefix: --force
  - id: gsize
    type:
      - 'null'
      - string
    doc: Estimated genome size eg. 3.2M <blank=AUTODETECT>
    inputBinding:
      position: 101
      prefix: --gsize
  - id: keepfiles
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    default: OFF
    inputBinding:
      position: 101
      prefix: --keepfiles
  - id: kmers
    type:
      - 'null'
      - string
    doc: K-mers to use <blank=AUTO>
    inputBinding:
      position: 101
      prefix: --kmers
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum contig coverage <0=AUTO>
    default: 2
    inputBinding:
      position: 101
      prefix: --mincov
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum contig length <0=AUTO>
    default: 0
    inputBinding:
      position: 101
      prefix: --minlen
  - id: namefmt
    type:
      - 'null'
      - string
    doc: Format of contig FASTA IDs in 'printf' style
    default: contig%05d
    inputBinding:
      position: 101
      prefix: --namefmt
  - id: nocorr
    type:
      - 'null'
      - boolean
    doc: Disable post-assembly correction
    default: OFF
    inputBinding:
      position: 101
      prefix: --nocorr
  - id: noreadcorr
    type:
      - 'null'
      - boolean
    doc: Disable read error correction
    default: OFF
    inputBinding:
      position: 101
      prefix: --noreadcorr
  - id: nostitch
    type:
      - 'null'
      - boolean
    doc: Disable read stitching
    default: OFF
    inputBinding:
      position: 101
      prefix: --nostitch
  - id: opts
    type:
      - 'null'
      - string
    doc: "Extra assembler options in quotes eg. spades: '--sc'"
    inputBinding:
      position: 101
      prefix: --opts
  - id: outdir
    type: Directory
    doc: Output folder
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plasmid
    type:
      - 'null'
      - boolean
    doc: Use plasmid mode if availabnlke
    default: OFF
    inputBinding:
      position: 101
      prefix: --plasmid
  - id: r1
    type: File
    doc: Read 1 FASTQ
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type: File
    doc: Read 2 FASTQ
    inputBinding:
      position: 101
      prefix: --R2
  - id: ram
    type:
      - 'null'
      - float
    doc: Try to keep RAM usage below this many GB
    default: 16
    inputBinding:
      position: 101
      prefix: --ram
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Fast temporary directory (blank=AUTO)
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Enable adaptor trimming
    default: OFF
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shovill:1.4.2--hdfd78af_0
stdout: shovill.out
