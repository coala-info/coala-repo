cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - sort
label: igvtools_sort
doc: "Sorts an alignment file by start position. The input file must be a .sam, .bam,
  .aligned, or .vcf file.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: The input file (SAM, BAM, aligned, or VCF) to be sorted.
    inputBinding:
      position: 1
  - id: max_records
    type:
      - 'null'
      - int
    doc: Maximum number of records to keep in memory before spilling to disk.
    inputBinding:
      position: 102
      prefix: -m
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files created during sorting.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file name. If not specified, the tool typically appends 
      '.sorted' to the input filename.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
