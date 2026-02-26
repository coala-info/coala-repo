cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobambam_bamtofastq
label: biobambam_bamtofastq
doc: "Convert BAM/SAM/CRAM to FASTQ format.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: casava18
    type:
      - 'null'
      - int
    doc: restore input taken by c18pe option
    default: 0
    inputBinding:
      position: 101
      prefix: casava18
  - id: colhlog
    type:
      - 'null'
      - int
    doc: base 2 logarithm of hash table size used for collation
    default: 18
    inputBinding:
      position: 101
      prefix: colhlog
  - id: collate
    type:
      - 'null'
      - int
    doc: collate pairs
    default: 1
    inputBinding:
      position: 101
      prefix: collate
  - id: colsbs
    type:
      - 'null'
      - int
    doc: size of hash table overflow list in bytes
    default: 33554432
    inputBinding:
      position: 101
      prefix: colsbs
  - id: combs
    type:
      - 'null'
      - int
    doc: print some counts after collation based processing
    default: 0
    inputBinding:
      position: 101
      prefix: combs
  - id: compress_output
    type:
      - 'null'
      - int
    doc: 'compress output streams in gzip format (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: gz
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression setting if gz=1 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    default: -1
    inputBinding:
      position: 101
      prefix: level
  - id: disable_validation
    type:
      - 'null'
      - int
    doc: disable validation of input data
    default: 0
    inputBinding:
      position: 101
      prefix: disablevalidation
  - id: exclude
    type:
      - 'null'
      - string
    doc: exclude alignments matching any of the given flags
    default: SECONDARY,SUPPLEMENTARY
    inputBinding:
      position: 101
      prefix: exclude
  - id: input_buffer_size
    type:
      - 'null'
      - int
    doc: size of input buffer
    default: -1
    inputBinding:
      position: 101
      prefix: inputbuffersize
  - id: input_filename
    type:
      - 'null'
      - File
    doc: 'input filename (default: read file from standard input)'
    default: stdin
    inputBinding:
      position: 101
      prefix: filename
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: cram, bam or sam'
    default: bam
    inputBinding:
      position: 101
      prefix: inputformat
  - id: matched_pairs_first_mates
    type:
      - 'null'
      - File
    doc: matched pairs first mates
    default: stdout
    inputBinding:
      position: 101
      prefix: F
  - id: matched_pairs_second_mates
    type:
      - 'null'
      - File
    doc: matched pairs second mates
    default: stdout
    inputBinding:
      position: 101
      prefix: F2
  - id: max_output
    type:
      - 'null'
      - int
    doc: 'output no more than this number of entries (default: no limit, collate=0
      only)'
    inputBinding:
      position: 101
      prefix: maxoutput
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: 'directory for output if outputperreadgroup=1 (default: current directory)'
    inputBinding:
      position: 101
      prefix: outputdir
  - id: output_fasta
    type:
      - 'null'
      - int
    doc: output FastA instead of FastQ
    default: 0
    inputBinding:
      position: 101
      prefix: fasta
  - id: output_per_read_group
    type:
      - 'null'
      - int
    doc: split output per read group (for collate=1 only)
    default: 0
    inputBinding:
      position: 101
      prefix: outputperreadgroup
  - id: output_per_read_group_prefix
    type:
      - 'null'
      - string
    doc: prefix added in front of file names if outputperreadgroup=1 (for 
      collate=1 only)
    inputBinding:
      position: 101
      prefix: outputperreadgroupprefix
  - id: output_per_read_group_rgsm
    type:
      - 'null'
      - int
    doc: add read group field SM ahead of read group id when 
      outputperreadgroup=1 (for collate=1 only)
    default: 0
    inputBinding:
      position: 101
      prefix: outputperreadgrouprgsm
  - id: output_suffix_F
    type:
      - 'null'
      - string
    doc: suffix for F category when outputperreadgroup=1
    default: _1.fq
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixF
  - id: output_suffix_F2
    type:
      - 'null'
      - string
    doc: suffix for F2 category when outputperreadgroup=1
    default: _2.fq
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixF2
  - id: output_suffix_O
    type:
      - 'null'
      - string
    doc: suffix for O category when outputperreadgroup=1
    default: _o1.fq
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixO
  - id: output_suffix_O2
    type:
      - 'null'
      - string
    doc: suffix for O2 category when outputperreadgroup=1
    default: _o2.fq
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixO2
  - id: output_suffix_S
    type:
      - 'null'
      - string
    doc: suffix for S category when outputperreadgroup=1
    default: _s.fq
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixS
  - id: ranges
    type:
      - 'null'
      - string
    doc: 'input ranges (bam and cram input only, default: read complete file)'
    inputBinding:
      position: 101
      prefix: ranges
  - id: reference
    type:
      - 'null'
      - File
    doc: name of reference FastA in case of inputformat=cram
    inputBinding:
      position: 101
      prefix: reference
  - id: single_end
    type:
      - 'null'
      - File
    doc: single end
    default: stdout
    inputBinding:
      position: 101
      prefix: S
  - id: split
    type:
      - 'null'
      - int
    doc: 'split named output files into chunks of this amount of reads (0: do not
      split)'
    default: 0
    inputBinding:
      position: 101
      prefix: split
  - id: split_prefix
    type:
      - 'null'
      - string
    doc: file name prefix if collate=0 and split>0
    default: bamtofastq_split
    inputBinding:
      position: 101
      prefix: splitprefix
  - id: tags
    type:
      - 'null'
      - string
    doc: 'list of aux tags to be copied (default: do not copy any aux fields)'
    inputBinding:
      position: 101
      prefix: tags
  - id: temporary_file_name
    type:
      - 'null'
      - string
    doc: temporary file name
    default: bamtofastq_20b15d712873_1_1772005324
    inputBinding:
      position: 101
      prefix: T
  - id: try_oq
    type:
      - 'null'
      - int
    doc: use OQ field instead of quality field if present (collate={0,1} only)
    default: 0
    inputBinding:
      position: 101
      prefix: tryoq
  - id: unmatched_pairs_first_mates
    type:
      - 'null'
      - File
    doc: unmatched pairs first mates
    default: stdout
    inputBinding:
      position: 101
      prefix: O
  - id: unmatched_pairs_second_mates
    type:
      - 'null'
      - File
    doc: unmatched pairs second mates
    default: stdout
    inputBinding:
      position: 101
      prefix: O2
  - id: wrap_columns
    type:
      - 'null'
      - int
    doc: 'wrap sequence and quality lines at this number of columns (default: do not
      wrap, even numbers only)'
    inputBinding:
      position: 101
      prefix: cols
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
stdout: biobambam_bamtofastq.out
