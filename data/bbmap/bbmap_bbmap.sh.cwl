cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmap.sh
label: bbmap_bbmap.sh
doc: Fast and accurate splice-aware read aligner.
inputs:
  - id: reference
    type: File
    doc: Specify the reference sequence. Only do this ONCE, when building the 
      index (unless using 'nodisk').
    inputBinding:
      position: 101
      prefix: ref
  - id: input
    type:
      - 'null'
      - File
    doc: Primary reads input; required parameter for mapping.
    inputBinding:
      position: 101
      prefix: in
  - id: input2
    type:
      - 'null'
      - File
    doc: For paired reads in two files.
    inputBinding:
      position: 101
      prefix: in2
  - id: output
    type: string
    doc: Write all reads to this file.
    inputBinding:
      position: 101
      prefix: out
  - id: output_unmapped
    type: string
    doc: Write only unmapped reads to this file.
    inputBinding:
      position: 101
      prefix: outu
  - id: output_mapped
    type: string
    doc: Write only mapped reads to this file.
    inputBinding:
      position: 101
      prefix: outm
  - id: nodisk
    type:
      - 'null'
      - boolean
    doc: Set to true to build index in memory and write nothing to disk except 
      output.
    inputBinding:
      position: 101
      prefix: nodisk
  - id: build
    type:
      - 'null'
      - int
    doc: Unique numeric ID for multiple references in the same directory.
    inputBinding:
      position: 101
      prefix: build
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length, range 8-15.
    inputBinding:
      position: 101
      prefix: k
  - id: path
    type:
      - 'null'
      - Directory
    doc: Specify the location to write the index.
    inputBinding:
      position: 101
      prefix: path
  - id: use_modulo
    type:
      - 'null'
      - boolean
    doc: Reduces RAM by 50% and sensitivity slightly.
    inputBinding:
      position: 101
      prefix: usemodulo
  - id: rebuild
    type:
      - 'null'
      - boolean
    doc: Force a rebuild of the index.
    inputBinding:
      position: 101
      prefix: rebuild
  - id: interleaved
    type:
      - 'null'
      - string
    doc: True forces paired/interleaved input; false forces single-ended 
      mapping.
    inputBinding:
      position: 101
      prefix: interleaved
  - id: fasta_read_length
    type:
      - 'null'
      - int
    doc: Break up FASTA reads longer than this.
    inputBinding:
      position: 101
      prefix: fastareadlen
  - id: unpigz
    type:
      - 'null'
      - boolean
    doc: Spawn a pigz process for faster decompression.
    inputBinding:
      position: 101
      prefix: unpigz
  - id: touppercase
    type:
      - 'null'
      - boolean
    doc: Convert lowercase letters in reads to upper case.
    inputBinding:
      position: 101
      prefix: touppercase
  - id: reads
    type:
      - 'null'
      - int
    doc: Only process the first N reads.
    inputBinding:
      position: 101
      prefix: reads
  - id: samplerate
    type:
      - 'null'
      - float
    doc: Randomly select fraction of reads for mapping.
    inputBinding:
      position: 101
      prefix: samplerate
  - id: skipreads
    type:
      - 'null'
      - int
    doc: Skip the first N reads.
    inputBinding:
      position: 101
      prefix: skipreads
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Macro to run faster at reduced sensitivity.
    inputBinding:
      position: 101
      prefix: fast
  - id: slow
    type:
      - 'null'
      - boolean
    doc: Macro to run slower at greater sensitivity.
    inputBinding:
      position: 101
      prefix: slow
  - id: max_indel
    type:
      - 'null'
      - int
    doc: Don't look for indels longer than this.
    inputBinding:
      position: 101
      prefix: maxindel
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Approximate minimum alignment identity to look for.
    inputBinding:
      position: 101
      prefix: minid
  - id: local
    type:
      - 'null'
      - boolean
    doc: Set to true to use local, rather than global, alignments.
    inputBinding:
      position: 101
      prefix: local
  - id: threads
    type:
      - 'null'
      - string
    doc: Set to number of threads desired.
    inputBinding:
      position: 101
      prefix: threads
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: Set behavior on ambiguously-mapped reads (best, toss, random, all).
    inputBinding:
      position: 101
      prefix: ambiguous
  - id: quality_in
    type:
      - 'null'
      - string
    doc: Input quality value ASCII offset (33 or 64).
    inputBinding:
      position: 101
      prefix: qin
  - id: quality_trim
    type:
      - 'null'
      - string
    doc: Quality-trim ends before mapping (f, l, r, lr).
    inputBinding:
      position: 101
      prefix: qtrim
  - id: bam_script
    type: string
    doc: Write a shell script to turn sam output into sorted, indexed bam.
    inputBinding:
      position: 101
      prefix: bamscript
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Output reads in same order as input.
    inputBinding:
      position: 101
      prefix: ordered
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow process to overwrite existing files.
    inputBinding:
      position: 101
      prefix: overwrite
  - id: scafstats
    type: string
    doc: Statistics on how many reads mapped to which scaffold.
    inputBinding:
      position: 101
      prefix: scafstats
  - id: covstats
    type: string
    doc: Per-scaffold coverage info.
    inputBinding:
      position: 101
      prefix: covstats
  - id: rpkm
    type: string
    doc: Per-scaffold RPKM/FPKM counts.
    inputBinding:
      position: 101
      prefix: rpkm
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Write all reads to this file.
    outputBinding:
      glob: $(inputs.output)
  - id: output_output_unmapped
    type:
      - 'null'
      - File
    doc: Write only unmapped reads to this file.
    outputBinding:
      glob: $(inputs.output_unmapped)
  - id: output_output_mapped
    type:
      - 'null'
      - File
    doc: Write only mapped reads to this file.
    outputBinding:
      glob: $(inputs.output_mapped)
  - id: output_bam_script
    type:
      - 'null'
      - File
    doc: Write a shell script to turn sam output into sorted, indexed bam.
    outputBinding:
      glob: $(inputs.bam_script)
  - id: output_scafstats
    type:
      - 'null'
      - File
    doc: Statistics on how many reads mapped to which scaffold.
    outputBinding:
      glob: $(inputs.scafstats)
  - id: output_covstats
    type:
      - 'null'
      - File
    doc: Per-scaffold coverage info.
    outputBinding:
      glob: $(inputs.covstats)
  - id: output_rpkm
    type:
      - 'null'
      - File
    doc: Per-scaffold RPKM/FPKM counts.
    outputBinding:
      glob: $(inputs.rpkm)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.79--h9b5c0a0_0
s:url: https://sourceforge.net/projects/bbmap
$namespaces:
  s: https://schema.org/
