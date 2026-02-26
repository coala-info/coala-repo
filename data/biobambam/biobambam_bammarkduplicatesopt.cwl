cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobambam2
label: biobambam_bammarkduplicatesopt
doc: "Mark duplicates in BAM files.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: add_mate_cigar
    type:
      - 'null'
      - int
    doc: 'add mate cigar string field MC (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: colhashbits
    type:
      - 'null'
      - int
    doc: log_2 of size of hash table used for collation
    default: 20
    inputBinding:
      position: 101
  - id: collistsize
    type:
      - 'null'
      - int
    doc: output list size for collation
    default: 33554432
    inputBinding:
      position: 101
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression settings for output bam file 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    default: 6
    inputBinding:
      position: 101
  - id: create_dup_index
    type:
      - 'null'
      - int
    doc: 'create BAM index for duplicates file (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: create_dup_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum for duplicates output file (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: create_index
    type:
      - 'null'
      - int
    doc: 'create BAM index (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: create_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: dup_index_filename
    type:
      - 'null'
      - File
    doc: 'file name for BAM index file for duplicates file (default: extend duplicates
      output file name)'
    inputBinding:
      position: 101
  - id: dup_md5_filename
    type:
      - 'null'
      - File
    doc: 'file name for md5 check sum of dup file (default: extend duplicates output
      file name)'
    inputBinding:
      position: 101
  - id: fragbufsize
    type:
      - 'null'
      - int
    doc: size of each fragment/pair file buffer in bytes
    default: 50331648
    inputBinding:
      position: 101
  - id: index_filename
    type:
      - 'null'
      - File
    doc: 'file name for BAM index file (default: extend output file name)'
    inputBinding:
      position: 101
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file, stdin if unset
    inputBinding:
      position: 101
      prefix: I
  - id: input_format
    type:
      - 'null'
      - string
    doc: input format (bam,cram,maussam,sam,sbam)
    default: bam
    inputBinding:
      position: 101
  - id: input_threads
    type:
      - 'null'
      - int
    doc: 'input helper threads (for inputformat=bam only, default: 1)'
    default: 1
    inputBinding:
      position: 101
  - id: md5_filename
    type:
      - 'null'
      - File
    doc: 'file name for md5 check sum (default: extend output file name)'
    inputBinding:
      position: 101
  - id: metrics_file
    type:
      - 'null'
      - File
    doc: metrics file, stderr if unset
    inputBinding:
      position: 101
      prefix: M
  - id: mod
    type:
      - 'null'
      - int
    doc: print progress for each mod'th record/alignment
    default: 1048576
    inputBinding:
      position: 101
  - id: nucleotide_tag
    type:
      - 'null'
      - string
    doc: aux field id for nucleotide tag extraction
    inputBinding:
      position: 101
  - id: od_tag
    type:
      - 'null'
      - string
    doc: 'tag added for optical duplicates (default: od)'
    default: od
    inputBinding:
      position: 101
  - id: opt_min_pixel_dif
    type:
      - 'null'
      - int
    doc: 'pixel difference threshold for optical duplicates (default: 100)'
    default: 100
    inputBinding:
      position: 101
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (bam,cram,sam)
    default: bam
    inputBinding:
      position: 101
  - id: output_threads
    type:
      - 'null'
      - int
    doc: 'output helper threads (for outputformat=bam only, default: 1)'
    default: 1
    inputBinding:
      position: 101
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference FastA (.fai file required, for cram i/o only)
    inputBinding:
      position: 101
  - id: remove_duplicates
    type:
      - 'null'
      - int
    doc: 'remove duplicates (default: 0)'
    default: 0
    inputBinding:
      position: 101
  - id: rewrite_bam_level
    type:
      - 'null'
      - int
    doc: compression setting for rewritten input file if rewritebam=1 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    default: 6
    inputBinding:
      position: 101
  - id: rewrite_bam_mode
    type:
      - 'null'
      - int
    doc: compression of temporary alignment file when input is via stdin 
      (0=snappy,1=gzip/bam,2=copy)
    default: 0
    inputBinding:
      position: 101
  - id: tag
    type:
      - 'null'
      - string
    doc: aux field id for tag string extraction
    inputBinding:
      position: 101
  - id: tmpfile_prefix
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory'
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'print progress report (default: 1)'
    default: 1
    inputBinding:
      position: 101
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file, stdout if unset
    outputBinding:
      glob: $(inputs.output_file)
  - id: duplicates_output_file
    type:
      - 'null'
      - File
    doc: duplicates output file if rmdup=1
    outputBinding:
      glob: $(inputs.duplicates_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
