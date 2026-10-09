cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - sort
label: igvtools_sort
doc: "Sort a .bed, .gff, .cn, .igv, .sam or .bam file by start position.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: "Input file to sort"
    inputBinding:
      position: 10
  - id: output_name
    type: string
    doc: "Output file name"
    inputBinding:
      position: 11
  - id: tmp_dir
    type: ['null', string]
    doc: "Temporary working directory for intermediate sort results"
    inputBinding:
      position: 1
      prefix: --tmpDir
  - id: max_records
    type: ['null', int]
    doc: "Maximum number of records kept in memory during the sort (default 500000)"
    inputBinding:
      position: 1
      prefix: --maxRecords
outputs:
  - id: output_file
    type: File
    doc: "Sorted output file"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
