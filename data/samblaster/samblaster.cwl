cwlVersion: v1.2
class: CommandLineTool
baseCommand: samblaster
label: samblaster
doc: "Tool to mark duplicates and optionally output split reads and/or discordant
  pairs.\n\nTool homepage: https://github.com/GregoryFaust/samblaster"
inputs:
  - id: accept_dup_marks
    type:
      - 'null'
      - boolean
    doc: Accept duplicate marks already in input file instead of looking for 
      duplicates in the input.
    inputBinding:
      position: 101
      prefix: --acceptDupMarks
  - id: add_mate_tags
    type:
      - 'null'
      - boolean
    doc: Add MC and MQ tags to all output paired-end SAM lines.
    inputBinding:
      position: 101
      prefix: --addMateTags
  - id: compatibility_mode
    type:
      - 'null'
      - boolean
    doc: Run in compatibility mode; both 0x100 and 0x800 are considered 
      chimeric. Similar to BWA MEM -M option.
    inputBinding:
      position: 101
      prefix: -M
  - id: exclude_dups
    type:
      - 'null'
      - boolean
    doc: Exclude reads marked as duplicates from discordant, splitter, and/or 
      unmapped file.
    inputBinding:
      position: 101
      prefix: --excludeDups
  - id: ignore_unmated
    type:
      - 'null'
      - boolean
    doc: Suppress abort on unmated alignments. Use only when sure input is 
      read-id grouped, and either paired-end alignments have been filtered or 
      the input file contains singleton reads.
    inputBinding:
      position: 101
      prefix: --ignoreUnmated
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input sam file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Maximum allowed length of the SEQ/QUAL string in the input file. 
      Primarily useful for marking duplicates in files containing singleton long
      reads.
    default: 500
    inputBinding:
      position: 101
      prefix: --maxReadLength
  - id: max_split_count
    type:
      - 'null'
      - int
    doc: Maximum number of split alignments for a read to be included in 
      splitter file.
    default: 2
    inputBinding:
      position: 101
      prefix: --maxSplitCount
  - id: max_unmapped_bases
    type:
      - 'null'
      - int
    doc: Maximum number of un-aligned bases between two alignments to be 
      included in splitter file.
    default: 50
    inputBinding:
      position: 101
      prefix: --maxUnmappedBases
  - id: min_clip_size
    type:
      - 'null'
      - int
    doc: Minumum number of bases a mapped read must be clipped to be included in
      unmapped file.
    default: 20
    inputBinding:
      position: 101
      prefix: --minClipSize
  - id: min_indel_size
    type:
      - 'null'
      - int
    doc: Minimum structural variant feature size for split alignments to be 
      included in splitter file.
    default: 50
    inputBinding:
      position: 101
      prefix: --minIndelSize
  - id: min_non_overlap
    type:
      - 'null'
      - int
    doc: Minimum non-overlaping base pairs between two alignments for a read to 
      be included in splitter file.
    default: 20
    inputBinding:
      position: 101
      prefix: --minNonOverlap
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output fewer statistics.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: remove_dups
    type:
      - 'null'
      - boolean
    doc: Remove duplicates reads from all output files. (Implies --excludeDups).
    inputBinding:
      position: 101
      prefix: --removeDups
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output sam file for all input alignments
    outputBinding:
      glob: $(inputs.output_file)
  - id: discordant_file
    type:
      - 'null'
      - File
    doc: Output discordant read pairs to this file.
    outputBinding:
      glob: $(inputs.discordant_file)
  - id: splitter_file
    type:
      - 'null'
      - File
    doc: Output split reads to this file abiding by paramaters below.
    outputBinding:
      glob: $(inputs.splitter_file)
  - id: unmapped_file
    type:
      - 'null'
      - File
    doc: Output unmapped/clipped reads as FASTQ to this file abiding by 
      parameters below. Requires soft clipping in input file. Will output FASTQ 
      if QUAL information available, otherwise FASTA.
    outputBinding:
      glob: $(inputs.unmapped_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samblaster:0.1.26--h9948957_7
