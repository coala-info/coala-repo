cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsormadup
label: biobambam_bamsormadup
doc: "Sorts and marks duplicate reads in BAM files.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: input_file
    type: File
    doc: input BAM or SAM file (read from standard input)
  - id: SO
    type:
      - 'null'
      - string
    doc: output sort order (coordinate by default)
    inputBinding:
      position: 101
      prefix: SO=
      separate: false
  - id: crammode
    type:
      - 'null'
      - string
    doc: 'CRAM encoding profile (default: )'
    inputBinding:
      position: 101
      prefix: crammode=
      separate: false
  - id: digest
    type:
      - 'null'
      - string
    doc: hash digest computed for output stream (md5, sha512)
    inputBinding:
      position: 101
      prefix: digest=
      separate: false
  - id: digestfilename
    type:
      - 'null'
      - string
    doc: name of file for storing hash digest computed for output stream (not 
      stored by default)
    inputBinding:
      position: 101
      prefix: digestfilename=
      separate: false
  - id: fragmergepar
    type:
      - 'null'
      - int
    doc: 'threads used while merging fragment lists for duplicate marking (default:
      1)'
    inputBinding:
      position: 101
      prefix: fragmergepar=
      separate: false
  - id: indexfilename
    type:
      - 'null'
      - string
    doc: name of file for storing BAM index (not stored by default)
    inputBinding:
      position: 101
      prefix: indexfilename=
      separate: false
  - id: inputformat
    type:
      - 'null'
      - string
    doc: input format (sam,bam)
    inputBinding:
      position: 101
      prefix: inputformat=
      separate: false
  - id: level
    type:
      - 'null'
      - int
    doc: compression settings for output bam file 
      (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
    inputBinding:
      position: 101
      prefix: level=
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
  - id: numerical
    type:
      - 'null'
      - string
    doc: file name for storing numerical index (not stored by default)
    inputBinding:
      position: 101
      prefix: numerical=
      separate: false
  - id: numericalindexmod
    type:
      - 'null'
      - int
    doc: 'block size when producing numerical index (default: 1024)'
    inputBinding:
      position: 101
      prefix: numericalindexmod=
      separate: false
  - id: optminpixeldif
    type:
      - 'null'
      - int
    doc: 'pixel difference threshold for optical duplicates (default: 100)'
    inputBinding:
      position: 101
      prefix: optminpixeldif=
      separate: false
  - id: outputformat
    type:
      - 'null'
      - string
    doc: output format (sam,bam,cram)
    inputBinding:
      position: 101
      prefix: outputformat=
      separate: false
  - id: rcsupport
    type:
      - 'null'
      - int
    doc: 'add rc tag (unclipped coordinate, default: 0)'
    inputBinding:
      position: 101
      prefix: rcsupport=
      separate: false
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: reference FastA for writing cram
    inputBinding:
      position: 101
      prefix: reference=
      separate: false
  - id: seqchksumhash
    type:
      - 'null'
      - string
    doc: 'seqchksum digest function: crc32prod,crc32,md5,sha1,sha224,sha256,sha384,sha512,crc32prime32,crc32prime64,md5prime64,sha1prime64,sha224prime64,sha256prime64,sha384prime64,sha512prime64,crc32prime96,md5prime96,sha1prime96,sha224prime96,sha256prime96,sha384prime96,sha512prime96,crc32prime128,md5prime128,sha1prime128,sha224prime128,sha256prime128,sha384prime128,sha512prime128,crc32prime160,md5prime160,sha1prime160,sha224prime160,sha256prime160,sha384prime160,sha512prime160,crc32prime192,md5prime192,sha1prime192,sha224prime192,sha256prime192,sha384prime192,sha512prime192,crc32prime224,md5prime224,sha1prime224,sha224prime224,sha256prime224,sha384prime224,sha512prime224,crc32prime256,md5prime256,sha1prime256,sha224prime256,sha256prime256,sha384prime256,sha512prime256,null,sha512primesums,sha512primesums512,sha3_256,murmur3,murmur3primesums128'
    inputBinding:
      position: 101
      prefix: seqchksumhash=
      separate: false
  - id: templevel
    type:
      - 'null'
      - int
    doc: compression setting for temporary files (see level for options)
    inputBinding:
      position: 101
      prefix: templevel=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: threads=
      separate: false
  - id: tmpfile
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory'
    inputBinding:
      position: 101
      prefix: tmpfile=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (sorted, duplicate-marked alignments)
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
    doc: BAM index file (indexfilename=)
    outputBinding:
      glob: $(inputs.indexfilename)
  - id: digest_file
    type:
      - 'null'
      - File
    doc: hash digest file (digestfilename=)
    outputBinding:
      glob: $(inputs.digestfilename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
stdin: $(inputs.input_file.path)
stdout: biobambam_bamsormadup.out
