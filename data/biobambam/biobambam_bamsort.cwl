cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobambam_bamsort
label: biobambam_bamsort
doc: "Sorts BAM/SAM/CRAM files.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: add_dup_mark_support
    type:
      - 'null'
      - int
    doc: add info for streaming duplicate marking (for name collated input only,
      ignored for fixmate=0, disabled by default)
    default: 0
    inputBinding:
      position: 101
      prefix: adddupmarksupport
  - id: block_size_mb
    type:
      - 'null'
      - int
    doc: size of internal memory buffer used for sorting in MiB
    default: 1024
    inputBinding:
      position: 101
      prefix: blockmb
  - id: calculate_md_nm
    type:
      - 'null'
      - int
    doc: calculate MD and NM aux fields (for coordinate sorted output only)
    default: 0
    inputBinding:
      position: 101
      prefix: calmdnm
  - id: calculate_md_nm_reference
    type:
      - 'null'
      - File
    doc: reference for calculating MD and NM aux fields (calmdnm=1 only)
    inputBinding:
      position: 101
      prefix: calmdnmreference
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression settings for output bam file 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    default: 6
    inputBinding:
      position: 101
      prefix: level
  - id: create_index
    type:
      - 'null'
      - int
    doc: 'create BAM index (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: index
  - id: create_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum (default: 0)'
    default: 0
    inputBinding:
      position: 101
      prefix: md5
  - id: disable_validation
    type:
      - 'null'
      - int
    doc: disable input validation (default is 0)
    default: 0
    inputBinding:
      position: 101
      prefix: disablevalidation
  - id: fix_mates
    type:
      - 'null'
      - int
    doc: fix mate information (for name collated input only, disabled by 
      default)
    default: 0
    inputBinding:
      position: 101
      prefix: fixmates
  - id: hash_algorithm
    type:
      - 'null'
      - string
    doc: 'hash used for producing bamseqchksum type checksums (default: crc32prod)'
    default: crc32prod
    inputBinding:
      position: 101
      prefix: hash
  - id: index_filename
    type:
      - 'null'
      - string
    doc: file name for BAM index file
    inputBinding:
      position: 101
      prefix: indexfilename
  - id: input_file
    type:
      - 'null'
      - File
    doc: input filename (standard input if unset)
    default: stdin
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
      prefix: inputformat
  - id: input_threads
    type:
      - 'null'
      - int
    doc: 'input helper threads (for inputformat=bam only, default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: inputthreads
  - id: mark_duplicates
    type:
      - 'null'
      - int
    doc: mark duplicates (only when input name collated and output coordinate 
      sorted, disabled by default)
    default: 0
    inputBinding:
      position: 101
      prefix: markduplicates
  - id: md5_filename
    type:
      - 'null'
      - string
    doc: file name for md5 check sum
    inputBinding:
      position: 101
      prefix: md5filename
  - id: nucleotide_tag
    type:
      - 'null'
      - string
    doc: aux field id for nucleotide tag extraction (adddupmarksupport=1 only)
    inputBinding:
      position: 101
      prefix: nucltag
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format (bam,cram,sam)
    default: bam
    inputBinding:
      position: 101
      prefix: outputformat
  - id: output_threads
    type:
      - 'null'
      - int
    doc: 'output helper threads (for outputformat=bam only, default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: outputthreads
  - id: range
    type:
      - 'null'
      - string
    doc: coordinate range to be processed (for coordinate sorted indexed BAM 
      input only)
    inputBinding:
      position: 101
      prefix: range
  - id: recompute_md_nm_indeterminate_only
    type:
      - 'null'
      - int
    doc: only recalculate MD and NM in the presence of indeterminate bases 
      (calmdnm=1 only)
    default: 0
    inputBinding:
      position: 101
      prefix: calmdnmrecompindetonly
  - id: reference
    type:
      - 'null'
      - File
    doc: reference FastA (.fai file required, for cram i/o only)
    inputBinding:
      position: 101
      prefix: reference
  - id: remove_duplicates
    type:
      - 'null'
      - int
    doc: remove duplicates (only when input name collated and output coordinate 
      sorted, disabled by default)
    default: 0
    inputBinding:
      position: 101
      prefix: rmdup
  - id: sort_tag
    type:
      - 'null'
      - string
    doc: tag used by SO=tag (no default)
    inputBinding:
      position: 101
      prefix: sorttag
  - id: sort_threads
    type:
      - 'null'
      - int
    doc: 'threads used for sorting (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: sortthreads
  - id: sorting_order
    type:
      - 'null'
      - string
    doc: sorting order (coordinate, queryname, hash, tag, tagonly, queryname_HI 
      or queryname_lexicographic)
    default: coordinate
    inputBinding:
      position: 101
      prefix: SO
  - id: streaming
    type:
      - 'null'
      - int
    doc: do not open input files multiple times when set
    default: 1
    inputBinding:
      position: 101
      prefix: streaming
  - id: tag_for_dup_marking
    type:
      - 'null'
      - string
    doc: aux field id for tag string extraction (adddupmarksupport=1 only)
    inputBinding:
      position: 101
      prefix: tag
  - id: tmp_file_prefix
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory'
    inputBinding:
      position: 101
      prefix: tmpfile
  - id: verbose
    type:
      - 'null'
      - int
    doc: print progress report
    default: 1
    inputBinding:
      position: 101
      prefix: verbose
  - id: warn_change_md_nm
    type:
      - 'null'
      - int
    doc: warn when changing existing MD/NM fields (calmdnm=1 only)
    default: 0
    inputBinding:
      position: 101
      prefix: calmdnmwarnchange
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output filename (standard output if unset)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
