cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamauxmerge
label: biobambam_bamauxmerge
doc: "Merges BAM files.\n\nCopies aux fields from the reads of the first (unmapped)\
  \ BAM file to the reads of the second (mapped) BAM file. Both files must hold the\
  \ reads in the same name order.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Two BAM files, the unmapped BAM with the aux fields first, then the mapped
      BAM
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression settings for output bam file (1=fast,...,9=best,10-12)
    inputBinding:
      position: 102
      prefix: level=
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: print progress information
    inputBinding:
      position: 102
      prefix: verbose=
      separate: false
  - id: create_md5
    type:
      - 'null'
      - int
    doc: 'create md5 check sum (default: 0)'
    inputBinding:
      position: 102
      prefix: md5=
      separate: false
  - id: md5_filename
    type:
      - 'null'
      - string
    doc: 'file name for md5 check sum (default: extend output file name)'
    inputBinding:
      position: 102
      prefix: md5filename=
      separate: false
  - id: create_index
    type:
      - 'null'
      - int
    doc: 'create BAM index (default: 0)'
    inputBinding:
      position: 102
      prefix: index=
      separate: false
  - id: index_filename
    type:
      - 'null'
      - string
    doc: 'file name for BAM index file (default: extend output file name)'
    inputBinding:
      position: 102
      prefix: indexfilename=
      separate: false
  - id: tmpfile
    type:
      - 'null'
      - string
    doc: 'prefix for temporary files, default: create files in current directory'
    inputBinding:
      position: 102
      prefix: tmpfile=
      separate: false
  - id: output_file_path
    type: string
    doc: Output BAM file name
outputs:
  - id: output_file
    type: File
    doc: Output BAM file name
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: md5
    type:
      - 'null'
      - File
    doc: md5 check sum file
    outputBinding:
      glob: $(inputs.md5_filename)
  - id: index
    type:
      - 'null'
      - File
    doc: BAM index file
    outputBinding:
      glob: $(inputs.index_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
stdout: $(inputs.output_file_path)
