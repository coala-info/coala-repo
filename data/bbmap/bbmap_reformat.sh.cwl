cwlVersion: v1.2
class: CommandLineTool
baseCommand: reformat.sh
label: bbmap_reformat
doc: "Reformats reads to change ASCII quality encoding, interleaving, file format,
  or compression format. Optionally performs additional functions such as quality
  trimming, subsetting, and subsampling.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to files that already exist
    inputBinding:
      position: 101
      prefix: app
  - id: fasta_min_len
    type:
      - 'null'
      - int
    doc: Ignore fasta reads shorter than this
    inputBinding:
      position: 101
      prefix: fastaminlen
  - id: fasta_read_len
    type:
      - 'null'
      - int
    doc: Set to a non-zero number to break fasta files into reads of at most this
      length
    inputBinding:
      position: 101
      prefix: fastareadlen
  - id: fasta_wrap
    type:
      - 'null'
      - int
    doc: Length of lines in fasta output
    inputBinding:
      position: 101
      prefix: fastawrap
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: in
  - id: input_file_2
    type:
      - 'null'
      - File
    doc: Second input file for paired reads
    inputBinding:
      position: 101
      prefix: in2
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Determines whether INPUT file is considered interleaved
    inputBinding:
      position: 101
      prefix: int
  - id: mapped_only
    type:
      - 'null'
      - boolean
    doc: Toss unmapped reads
    inputBinding:
      position: 101
      prefix: mappedonly
  - id: min_avg_quality
    type:
      - 'null'
      - float
    doc: Reads with average quality (after trimming) below this will be discarded
    inputBinding:
      position: 101
      prefix: minavgquality
  - id: min_length
    type:
      - 'null'
      - int
    doc: Reads shorter than this after trimming will be discarded
    inputBinding:
      position: 101
      prefix: minlength
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: If non-negative, toss reads with mapq under this
    inputBinding:
      position: 101
      prefix: minmapq
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites files that already exist
    inputBinding:
      position: 101
      prefix: ow
  - id: quality_fake
    type:
      - 'null'
      - int
    doc: Quality value used for fasta to fastq reformatting
    inputBinding:
      position: 101
      prefix: qfake
  - id: quality_file_in
    type:
      - 'null'
      - File
    doc: Read qualities from this qual file for 'in'
    inputBinding:
      position: 101
      prefix: qfin
  - id: quality_file_in2
    type:
      - 'null'
      - File
    doc: Read qualities from this qual file for 'in2'
    inputBinding:
      position: 101
      prefix: qfin2
  - id: quality_in
    type:
      - 'null'
      - string
    doc: ASCII offset for input quality. May be 33 (Sanger), 64 (Illumina), or auto
    inputBinding:
      position: 101
      prefix: qin
  - id: quality_out
    type:
      - 'null'
      - string
    doc: ASCII offset for output quality. May be 33 (Sanger), 64 (Illumina), or auto
    inputBinding:
      position: 101
      prefix: qout
  - id: quality_trim
    type:
      - 'null'
      - string
    doc: Trim read ends to remove bases with quality below trimq (t, f, r, l, w)
    inputBinding:
      position: 101
      prefix: qtrim
  - id: reads
    type:
      - 'null'
      - int
    doc: Set to a positive number to only process this many INPUT reads
    inputBinding:
      position: 101
      prefix: reads
  - id: reference
    type:
      - 'null'
      - File
    doc: Optional reference fasta for sam processing
    inputBinding:
      position: 101
      prefix: ref
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Reverse-complement reads
    inputBinding:
      position: 101
      prefix: rcomp
  - id: sample_rate
    type:
      - 'null'
      - float
    doc: Randomly output only this fraction of reads
    inputBinding:
      position: 101
      prefix: samplerate
  - id: trim_quality
    type:
      - 'null'
      - float
    doc: Regions with average quality BELOW this will be trimmed
    inputBinding:
      position: 101
      prefix: trimq
  - id: verify_paired
    type:
      - 'null'
      - boolean
    doc: When true, checks reads to see if the names look paired
    inputBinding:
      position: 101
      prefix: verifypaired
  - id: ziplevel
    type:
      - 'null'
      - int
    doc: Set compression level, 1 (low) to 9 (max)
    inputBinding:
      position: 101
      prefix: zl
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_file_2
    type:
      - 'null'
      - File
    doc: Second output file for paired reads
    outputBinding:
      glob: $(inputs.output_file_2)
  - id: quality_file_out
    type:
      - 'null'
      - File
    doc: Write qualities to this qual file for 'out'
    outputBinding:
      glob: $(inputs.quality_file_out)
  - id: output_single
    type:
      - 'null'
      - File
    doc: If a read is longer than minlength and its mate is shorter, the longer one
      goes here
    outputBinding:
      glob: $(inputs.output_single)
  - id: base_hist
    type:
      - 'null'
      - File
    doc: Base composition histogram by position
    outputBinding:
      glob: $(inputs.base_hist)
  - id: quality_hist
    type:
      - 'null'
      - File
    doc: Quality histogram by position
    outputBinding:
      glob: $(inputs.quality_hist)
  - id: length_hist
    type:
      - 'null'
      - File
    doc: Read length histogram
    outputBinding:
      glob: $(inputs.length_hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
