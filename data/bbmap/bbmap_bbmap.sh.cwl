cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmap.sh
label: bbmap
doc: "Fast and accurate splice-aware read aligner.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: Set behavior on ambiguously-mapped reads (best, toss, random, all).
    default: best
    inputBinding:
      position: 101
      prefix: ambiguous
  - id: build
    type:
      - 'null'
      - int
    doc: Unique numeric ID for indexed references in the same directory.
    default: 1
    inputBinding:
      position: 101
      prefix: build
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Macro to run faster at reduced sensitivity.
    default: false
    inputBinding:
      position: 101
      prefix: fast
  - id: fastareadlen
    type:
      - 'null'
      - int
    doc: Break up FASTA reads longer than this.
    default: 500
    inputBinding:
      position: 101
      prefix: fastareadlen
  - id: in
    type: File
    doc: Primary reads input; required parameter.
    inputBinding:
      position: 101
      prefix: in
  - id: in2
    type:
      - 'null'
      - File
    doc: For paired reads in two files.
    inputBinding:
      position: 101
      prefix: in2
  - id: interleaved
    type:
      - 'null'
      - string
    doc: True forces paired/interleaved input; false forces single-ended mapping.
    default: auto
    inputBinding:
      position: 101
      prefix: interleaved
  - id: java_memory
    type:
      - 'null'
      - string
    doc: Set Java's memory usage (e.g. -Xmx20g).
    inputBinding:
      position: 101
      prefix: -Xmx
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer length, range 8-15.
    default: 13
    inputBinding:
      position: 101
      prefix: k
  - id: local
    type:
      - 'null'
      - boolean
    doc: Set to true to use local, rather than global, alignments.
    default: false
    inputBinding:
      position: 101
      prefix: local
  - id: maxindel
    type:
      - 'null'
      - int
    doc: Don't look for indels longer than this.
    default: 16000
    inputBinding:
      position: 101
      prefix: maxindel
  - id: maxsites
    type:
      - 'null'
      - int
    doc: Maximum number of total alignments to print per read.
    default: 5
    inputBinding:
      position: 101
      prefix: maxsites
  - id: minid
    type:
      - 'null'
      - float
    doc: Approximate minimum alignment identity to look for.
    default: 0.76
    inputBinding:
      position: 101
      prefix: minid
  - id: nodisk
    type:
      - 'null'
      - boolean
    doc: Set to true to build index in memory and write nothing to disk except output.
    default: false
    inputBinding:
      position: 101
      prefix: nodisk
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Set to true to output reads in same order as input.
    default: false
    inputBinding:
      position: 101
      prefix: ordered
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow process to overwrite existing files.
    default: false
    inputBinding:
      position: 101
      prefix: overwrite
  - id: path
    type:
      - 'null'
      - Directory
    doc: Specify the location to write the index.
    inputBinding:
      position: 101
      prefix: path
  - id: pigz
    type:
      - 'null'
      - boolean
    doc: Spawn a pigz process for faster compression.
    default: false
    inputBinding:
      position: 101
      prefix: pigz
  - id: reads
    type:
      - 'null'
      - int
    doc: Set to a positive number N to only process the first N reads.
    default: -1
    inputBinding:
      position: 101
      prefix: reads
  - id: rebuild
    type:
      - 'null'
      - boolean
    doc: Force a rebuild of the index.
    default: false
    inputBinding:
      position: 101
      prefix: rebuild
  - id: ref
    type:
      - 'null'
      - File
    doc: Specify the reference sequence. Only do this ONCE, when building the index
      (unless using 'nodisk').
    inputBinding:
      position: 101
      prefix: ref
  - id: samplerate
    type:
      - 'null'
      - float
    doc: Fraction of reads to randomly select for mapping.
    default: 1
    inputBinding:
      position: 101
      prefix: samplerate
  - id: secondary
    type:
      - 'null'
      - boolean
    doc: Print secondary alignments.
    default: false
    inputBinding:
      position: 101
      prefix: secondary
  - id: skipreads
    type:
      - 'null'
      - int
    doc: Skip the first N reads.
    default: 0
    inputBinding:
      position: 101
      prefix: skipreads
  - id: slow
    type:
      - 'null'
      - boolean
    doc: Macro to run slower at greater sensitivity.
    default: false
    inputBinding:
      position: 101
      prefix: slow
  - id: threads
    type:
      - 'null'
      - string
    doc: Set to number of threads desired.
    default: auto
    inputBinding:
      position: 101
      prefix: threads
  - id: touppercase
    type:
      - 'null'
      - boolean
    doc: Convert lowercase letters in reads to upper case.
    default: true
    inputBinding:
      position: 101
      prefix: touppercase
  - id: unpigz
    type:
      - 'null'
      - boolean
    doc: Spawn a pigz process for faster decompression.
    default: false
    inputBinding:
      position: 101
      prefix: unpigz
  - id: usemodulo
    type:
      - 'null'
      - boolean
    doc: Throw away ~80% of kmers based on remainder modulo a number.
    default: false
    inputBinding:
      position: 101
      prefix: usemodulo
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write all reads to this file.
    outputBinding:
      glob: $(inputs.out)
  - id: outu
    type:
      - 'null'
      - File
    doc: Write only unmapped reads to this file.
    outputBinding:
      glob: $(inputs.outu)
  - id: outm
    type:
      - 'null'
      - File
    doc: Write only mapped reads to this file.
    outputBinding:
      glob: $(inputs.outm)
  - id: bamscript
    type:
      - 'null'
      - File
    doc: Write a shell script to turn sam output into sorted, indexed bam.
    outputBinding:
      glob: $(inputs.bamscript)
  - id: scafstats
    type:
      - 'null'
      - File
    doc: Statistics on how many reads mapped to which scaffold.
    outputBinding:
      glob: $(inputs.scafstats)
  - id: covstats
    type:
      - 'null'
      - File
    doc: Per-scaffold coverage info.
    outputBinding:
      glob: $(inputs.covstats)
  - id: rpkm
    type:
      - 'null'
      - File
    doc: Per-scaffold RPKM/FPKM counts.
    outputBinding:
      glob: $(inputs.rpkm)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
