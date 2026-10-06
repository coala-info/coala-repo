cwlVersion: v1.2
class: CommandLineTool
baseCommand: bammarkduplicatesopt
label: biobambam_bammarkduplicatesopt
doc: "Mark duplicates in BAM files.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: add_mate_cigar
    type:
      - 'null'
      - int
    doc: 'add mate cigar string field MC (default: 0)'
    inputBinding:
      position: 101
      prefix: addmatecigar=
      separate: false
  - id: colhashbits
    type:
      - 'null'
      - int
    doc: log_2 of size of hash table used for collation
    inputBinding:
      position: 101
      prefix: colhashbits=
      separate: false
  - id: collistsize
    type:
      - 'null'
      - int
    doc: output list size for collation
    inputBinding:
      position: 101
      prefix: collistsize=
      separate: false
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression settings for output bam file 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    inputBinding:
      position: 101
      prefix: level=
      separate: false
  - id: create_dup_index
    type:
      - 'null'
      - int
    doc: 'create BAM index for duplicates file (default: 0)'
    inputBinding:
      position: 101
      prefix: dupindex=
      separate: false
  - id: create_dup_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum for duplicates output file (default: 0)'
    inputBinding:
      position: 101
      prefix: dupmd5=
      separate: false
  - id: create_index
    type:
      - 'null'
      - int
    doc: 'create BAM index (default: 0)'
    inputBinding:
      position: 101
      prefix: index=
      separate: false
  - id: create_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum (default: 0)'
    inputBinding:
      position: 101
      prefix: md5=
      separate: false
  - id: dup_index_filename
    type:
      - 'null'
      - string
    doc: 'file name for BAM index file for duplicates file (default: extend duplicates
      output file name)'
    inputBinding:
      position: 101
      prefix: dupindexfilename=
      separate: false
  - id: dup_md5_filename
    type:
      - 'null'
      - string
    doc: 'file name for md5 check sum of dup file (default: extend duplicates output
      file name)'
    inputBinding:
      position: 101
      prefix: dupmd5filename=
      separate: false
  - id: fragbufsize
    type:
      - 'null'
      - int
    doc: size of each fragment/pair file buffer in bytes
    inputBinding:
      position: 101
      prefix: fragbufsize=
      separate: false
  - id: index_filename
    type:
      - 'null'
      - string
    doc: 'file name for BAM index file (default: extend output file name)'
    inputBinding:
      position: 101
      prefix: indexfilename=
      separate: false
  - id: input_file
    type: File
    doc: input file, stdin if unset
    inputBinding:
      position: 101
      prefix: I=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: input format (bam,cram,maussam,sam,sbam)
    inputBinding:
      position: 101
      prefix: inputformat=
      separate: false
  - id: input_threads
    type:
      - 'null'
      - int
    doc: 'input helper threads (for inputformat=bam only, default: 1)'
    inputBinding:
      position: 101
      prefix: inputthreads=
      separate: false
  - id: md5_filename
    type:
      - 'null'
      - string
    doc: 'file name for md5 check sum (default: extend output file name)'
    inputBinding:
      position: 101
      prefix: md5filename=
      separate: false
  - id: metrics_file
    type:
      - 'null'
      - string
    doc: metrics file, stderr if unset
    inputBinding:
      position: 101
      prefix: M=
      separate: false
  - id: mod
    type:
      - 'null'
      - int
    doc: print progress for each mod'th record/alignment
    inputBinding:
      position: 101
      prefix: mod=
      separate: false
  - id: nucleotide_tag
    type:
      - 'null'
      - string
    doc: aux field id for nucleotide tag extraction
    inputBinding:
      position: 101
      prefix: nucltag=
      separate: false
  - id: od_tag
    type:
      - 'null'
      - string
    doc: 'tag added for optical duplicates (default: od)'
    inputBinding:
      position: 101
      prefix: odtag=
      separate: false
  - id: opt_min_pixel_dif
    type:
      - 'null'
      - int
    doc: 'pixel difference threshold for optical duplicates (default: 100)'
    inputBinding:
      position: 101
      prefix: optminpixeldif=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (bam,cram,sam)
    inputBinding:
      position: 101
      prefix: outputformat=
      separate: false
  - id: output_threads
    type:
      - 'null'
      - int
    doc: 'output helper threads (for outputformat=bam only, default: 1)'
    inputBinding:
      position: 101
      prefix: outputthreads=
      separate: false
  - id: reference_fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: reference FastA (.fai file required, for cram i/o only)
    inputBinding:
      position: 101
      prefix: reference=
      separate: false
  - id: remove_duplicates
    type:
      - 'null'
      - int
    doc: 'remove duplicates (default: 0)'
    inputBinding:
      position: 101
      prefix: rmdup=
      separate: false
  - id: rewrite_bam_level
    type:
      - 'null'
      - int
    doc: compression setting for rewritten input file if rewritebam=1 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    inputBinding:
      position: 101
      prefix: rewritebamlevel=
      separate: false
  - id: rewrite_bam_mode
    type:
      - 'null'
      - int
    doc: compression of temporary alignment file when input is via stdin 
      (0=snappy,1=gzip/bam,2=copy)
    inputBinding:
      position: 101
      prefix: rewritebam=
      separate: false
  - id: tag
    type:
      - 'null'
      - string
    doc: aux field id for tag string extraction
    inputBinding:
      position: 101
      prefix: tag=
      separate: false
  - id: tmpfile_prefix
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory'
    inputBinding:
      position: 101
      prefix: tmpfile=
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'print progress report (default: 1)'
    inputBinding:
      position: 101
      prefix: verbose=
      separate: false
  - id: duplicates_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `duplicates_output_file_path`
    inputBinding:
      position: 101
      prefix: D=
      separate: false
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: O=
      separate: false
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file, stdout if unset
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: duplicates_output_file
    type:
      - 'null'
      - File
    doc: duplicates output file if rmdup=1
    outputBinding:
      glob: $(inputs.duplicates_output_file_path)
  - id: metrics
    type:
      - 'null'
      - File
    doc: duplicate metrics file (M=)
    outputBinding:
      glob: $(inputs.metrics_file)
  - id: index
    type:
      - 'null'
      - File
    doc: BAM index file (index=1 with indexfilename=)
    outputBinding:
      glob: $(inputs.index_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
