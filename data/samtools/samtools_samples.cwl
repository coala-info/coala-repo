cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - samples
label: samtools_samples
doc: "List samples from BAM/CRAM files, optionally checking for indices and associating
  with reference fasta files.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    inputBinding:
      position: 1
  - id: custom_index
    type:
      - 'null'
      - boolean
    doc: use a custom index file.
    inputBinding:
      position: 102
      prefix: -X
  - id: header
    type:
      - 'null'
      - boolean
    doc: add the columns header before printing the results
    inputBinding:
      position: 102
      prefix: -h
  - id: reference_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: load an indexed fasta file in the collection of references. Can be used
      multiple times.
    inputBinding:
      position: 102
      prefix: -f
  - id: reference_list_file
    type:
      - 'null'
      - File
    doc: read a file containing the paths to indexed fasta files. One path per 
      line.
    inputBinding:
      position: 102
      prefix: -F
  - id: sample_tag
    type:
      - 'null'
      - string
    doc: provide the sample tag name from the @RG line [SM].
    default: SM
    inputBinding:
      position: 102
      prefix: -T
  - id: test_indexed
    type:
      - 'null'
      - boolean
    doc: test if the file is indexed.
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file [stdout].
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
