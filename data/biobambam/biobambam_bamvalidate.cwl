cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobambam2
label: biobambam_bamvalidate
doc: "Validate BAM/CRAM files and perform conversions.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: basequalhist
    type:
      - 'null'
      - boolean
    doc: print base quality histogram at end of a successful run
    inputBinding:
      position: 101
      prefix: basequalhist
  - id: index
    type:
      - 'null'
      - boolean
    doc: 'create BAM index (default: 0, passthrough=1 only)'
    inputBinding:
      position: 101
      prefix: index
  - id: indexfilename
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
    inputBinding:
      position: 101
      prefix: I
  - id: inputformat
    type:
      - 'null'
      - string
    doc: input format (bam,cram,maussam,sam,sbam)
    inputBinding:
      position: 101
      prefix: inputformat
  - id: inputthreads
    type:
      - 'null'
      - int
    doc: 'input helper threads (for inputformat=bam only, default: 1)'
    inputBinding:
      position: 101
      prefix: inputthreads
  - id: md5
    type:
      - 'null'
      - boolean
    doc: 'create md5 check sum (default: 0, passthrough=1 only)'
    inputBinding:
      position: 101
      prefix: md5
  - id: md5filename
    type:
      - 'null'
      - string
    doc: file name for md5 check sum
    inputBinding:
      position: 101
      prefix: md5filename
  - id: outputformat
    type:
      - 'null'
      - string
    doc: output format (bam,cram,sam, passthrough=1 only)
    inputBinding:
      position: 101
      prefix: outputformat
  - id: outputthreads
    type:
      - 'null'
      - int
    doc: 'output helper threads (for outputformat=bam only, default: 1, passthrough=1
      only)'
    inputBinding:
      position: 101
      prefix: outputthreads
  - id: passthrough
    type:
      - 'null'
      - boolean
    doc: 'write alignments to standard output (default: do not pass through)'
    inputBinding:
      position: 101
      prefix: passthrough
  - id: range
    type:
      - 'null'
      - string
    doc: coordinate range to be processed (for coordinate sorted indexed BAM 
      input only)
    inputBinding:
      position: 101
      prefix: range
  - id: reference
    type:
      - 'null'
      - File
    doc: reference FastA (.fai file required, for cram i/o only)
    inputBinding:
      position: 101
      prefix: reference
  - id: tmpfile
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory (passthrough=1,
      index=1 only)'
    inputBinding:
      position: 101
      prefix: tmpfile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print stats at the end of a successful run
    inputBinding:
      position: 101
      prefix: verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output filename (standard output if unset, passthrough=1 only)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
