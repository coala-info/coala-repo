cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtofastq
label: biobambam_bamtofastq
doc: "Convert BAM/SAM/CRAM to FASTQ format.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: casava18
    type:
      - 'null'
      - int
    doc: restore input taken by c18pe option
    inputBinding:
      position: 101
      prefix: casava18=
      separate: false
  - id: colhlog
    type:
      - 'null'
      - int
    doc: base 2 logarithm of hash table size used for collation
    inputBinding:
      position: 101
      prefix: colhlog=
      separate: false
  - id: collate
    type:
      - 'null'
      - int
    doc: collate pairs
    inputBinding:
      position: 101
      prefix: collate=
      separate: false
  - id: colsbs
    type:
      - 'null'
      - int
    doc: size of hash table overflow list in bytes
    inputBinding:
      position: 101
      prefix: colsbs=
      separate: false
  - id: combs
    type:
      - 'null'
      - int
    doc: print some counts after collation based processing
    inputBinding:
      position: 101
      prefix: combs=
      separate: false
  - id: compress_output
    type:
      - 'null'
      - int
    doc: 'compress output streams in gzip format (default: 0)'
    inputBinding:
      position: 101
      prefix: gz=
      separate: false
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression setting if gz=1 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    inputBinding:
      position: 101
      prefix: level=
      separate: false
  - id: disable_validation
    type:
      - 'null'
      - int
    doc: disable validation of input data
    inputBinding:
      position: 101
      prefix: disablevalidation=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: exclude alignments matching any of the given flags
    inputBinding:
      position: 101
      prefix: exclude=
      separate: false
  - id: input_buffer_size
    type:
      - 'null'
      - int
    doc: size of input buffer
    inputBinding:
      position: 101
      prefix: inputbuffersize=
      separate: false
  - id: input_filename
    type: File
    doc: 'input filename (default: read file from standard input)'
    inputBinding:
      position: 101
      prefix: filename=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: cram, bam or sam'
    inputBinding:
      position: 101
      prefix: inputformat=
      separate: false
  - id: matched_pairs_first_mates
    type:
      - 'null'
      - string
    doc: matched pairs first mates
    inputBinding:
      position: 101
      prefix: F=
      separate: false
  - id: matched_pairs_second_mates
    type:
      - 'null'
      - string
    doc: matched pairs second mates
    inputBinding:
      position: 101
      prefix: F2=
      separate: false
  - id: max_output
    type:
      - 'null'
      - int
    doc: 'output no more than this number of entries (default: no limit, collate=0
      only)'
    inputBinding:
      position: 101
      prefix: maxoutput=
      separate: false
  - id: output_directory
    type:
      - 'null'
      - string
    doc: 'directory for output if outputperreadgroup=1 (default: current directory)'
    inputBinding:
      position: 101
      prefix: outputdir=
      separate: false
  - id: output_fasta
    type:
      - 'null'
      - int
    doc: output FastA instead of FastQ
    inputBinding:
      position: 101
      prefix: fasta=
      separate: false
  - id: output_per_read_group
    type:
      - 'null'
      - int
    doc: split output per read group (for collate=1 only)
    inputBinding:
      position: 101
      prefix: outputperreadgroup=
      separate: false
  - id: output_per_read_group_prefix
    type:
      - 'null'
      - string
    doc: prefix added in front of file names if outputperreadgroup=1 (for 
      collate=1 only)
    inputBinding:
      position: 101
      prefix: outputperreadgroupprefix=
      separate: false
  - id: output_per_read_group_rgsm
    type:
      - 'null'
      - int
    doc: add read group field SM ahead of read group id when 
      outputperreadgroup=1 (for collate=1 only)
    inputBinding:
      position: 101
      prefix: outputperreadgrouprgsm=
      separate: false
  - id: output_suffix_F
    type:
      - 'null'
      - string
    doc: suffix for F category when outputperreadgroup=1
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixF=
      separate: false
  - id: output_suffix_F2
    type:
      - 'null'
      - string
    doc: suffix for F2 category when outputperreadgroup=1
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixF2=
      separate: false
  - id: output_suffix_O
    type:
      - 'null'
      - string
    doc: suffix for O category when outputperreadgroup=1
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixO=
      separate: false
  - id: output_suffix_O2
    type:
      - 'null'
      - string
    doc: suffix for O2 category when outputperreadgroup=1
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixO2=
      separate: false
  - id: output_suffix_S
    type:
      - 'null'
      - string
    doc: suffix for S category when outputperreadgroup=1
    inputBinding:
      position: 101
      prefix: outputperreadgroupsuffixS=
      separate: false
  - id: ranges
    type:
      - 'null'
      - string
    doc: 'input ranges (bam and cram input only, default: read complete file)'
    inputBinding:
      position: 101
      prefix: ranges=
      separate: false
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: name of reference FastA in case of inputformat=cram
    inputBinding:
      position: 101
      prefix: reference=
      separate: false
  - id: single_end
    type:
      - 'null'
      - string
    doc: single end
    inputBinding:
      position: 101
      prefix: S=
      separate: false
  - id: split
    type:
      - 'null'
      - int
    doc: 'split named output files into chunks of this amount of reads (0: do not
      split)'
    inputBinding:
      position: 101
      prefix: split=
      separate: false
  - id: split_prefix
    type:
      - 'null'
      - string
    doc: file name prefix if collate=0 and split>0
    inputBinding:
      position: 101
      prefix: splitprefix=
      separate: false
  - id: tags
    type:
      - 'null'
      - string
    doc: 'list of aux tags to be copied (default: do not copy any aux fields)'
    inputBinding:
      position: 101
      prefix: tags=
      separate: false
  - id: temporary_file_name
    type:
      - 'null'
      - string
    doc: temporary file name
    inputBinding:
      position: 101
      prefix: T=
      separate: false
  - id: try_oq
    type:
      - 'null'
      - int
    doc: use OQ field instead of quality field if present (collate={0,1} only)
    inputBinding:
      position: 101
      prefix: tryoq=
      separate: false
  - id: unmatched_pairs_first_mates
    type:
      - 'null'
      - string
    doc: unmatched pairs first mates
    inputBinding:
      position: 101
      prefix: O=
      separate: false
  - id: unmatched_pairs_second_mates
    type:
      - 'null'
      - string
    doc: unmatched pairs second mates
    inputBinding:
      position: 101
      prefix: O2=
      separate: false
  - id: wrap_columns
    type:
      - 'null'
      - int
    doc: 'wrap sequence and quality lines at this number of columns (default: do not
      wrap, even numbers only)'
    inputBinding:
      position: 101
      prefix: cols=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: 'directory for output if outputperreadgroup=1 (default: current directory)'
    outputBinding:
      glob: $(inputs.output_directory)
  - id: first_mates
    type:
      - 'null'
      - File
    doc: matched pairs first mates (F=)
    outputBinding:
      glob: $(inputs.matched_pairs_first_mates)
  - id: second_mates
    type:
      - 'null'
      - File
    doc: matched pairs second mates (F2=)
    outputBinding:
      glob: $(inputs.matched_pairs_second_mates)
  - id: single_end_reads
    type:
      - 'null'
      - File
    doc: single end reads (S=)
    outputBinding:
      glob: $(inputs.single_end)
  - id: unmatched_first_mates
    type:
      - 'null'
      - File
    doc: unmatched pairs first mates (O=)
    outputBinding:
      glob: $(inputs.unmatched_pairs_first_mates)
  - id: unmatched_second_mates
    type:
      - 'null'
      - File
    doc: unmatched pairs second mates (O2=)
    outputBinding:
      glob: $(inputs.unmatched_pairs_second_mates)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
stdout: biobambam_bamtofastq.out
