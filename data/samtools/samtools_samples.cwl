cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- samples
label: samtools_samples
doc: 'List the samples in a set of SAM/BAM/CRAM files


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input
  type:
    type: array
    items: File
  doc: 'Input SAM/BAM/CRAM files (with custom_index: files followed by their indexes).'
  inputBinding:
    position: 104
- id: header
  type:
  - 'null'
  - boolean
  doc: Add the columns header before printing the results.
  inputBinding:
    position: 103
    prefix: -h
- id: test_indexed
  type:
  - 'null'
  - boolean
  doc: Test if the file is indexed.
  inputBinding:
    position: 103
    prefix: -i
- id: sample_tag
  type:
  - 'null'
  - string
  doc: Sample tag name from the @RG line [SM].
  inputBinding:
    position: 103
    prefix: -T
- id: output_filename
  type: string
  doc: Output file (-o).
  default: samples.txt
  inputBinding:
    position: 103
    prefix: -o
- id: reference_fasta
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: -f
  doc: Indexed FASTA files to add to the collection of references (-f, repeatable).
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
- id: reference_list_file
  type:
  - 'null'
  - File
  doc: File containing paths to indexed FASTA files, one per line (-F).
  inputBinding:
    position: 103
    prefix: -F
- id: custom_index
  type:
  - 'null'
  - boolean
  doc: Use a custom index file (-X).
  inputBinding:
    position: 103
    prefix: -X
outputs:
- id: output
  type: File
  doc: Table of samples per file.
  outputBinding:
    glob: $(inputs.output_filename)
