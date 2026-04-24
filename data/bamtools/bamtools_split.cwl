cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - split
label: bamtools_split
doc: "splits a BAM file on user-specified property, creating a new BAM output file
  for each value found.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: mapped
    type:
      - 'null'
      - boolean
    doc: split mapped/unmapped alignments
    inputBinding:
      position: 101
      prefix: -mapped
  - id: paired
    type:
      - 'null'
      - boolean
    doc: split single-end/paired-end alignments
    inputBinding:
      position: 101
      prefix: -paired
  - id: ref_prefix
    type:
      - 'null'
      - string
    doc: custom prefix for splitting by references. Currently files end with REF_<refName>.bam.
      This option allows you to replace "REF_" with a prefix of your choosing.
    inputBinding:
      position: 101
      prefix: -refPrefix
  - id: reference
    type:
      - 'null'
      - boolean
    doc: split alignments by reference
    inputBinding:
      position: 101
      prefix: -reference
  - id: tag
    type:
      - 'null'
      - string
    doc: splits alignments based on all values of TAG encountered (i.e. -tag RG creates
      a BAM file for each read group in original BAM file)
    inputBinding:
      position: 101
      prefix: -tag
  - id: tag_list_delim
    type:
      - 'null'
      - string
    doc: delimiter used to separate values in the filenames generated from splitting
      on list-type tags
    inputBinding:
      position: 101
      prefix: -tagListDelim
  - id: tag_prefix
    type:
      - 'null'
      - string
    doc: custom prefix for splitting by tags. Current files end with TAG_<tagname>_<tagvalue>.bam.
      This option allows you to replace "TAG_" with a prefix of your choosing.
    inputBinding:
      position: 101
      prefix: -tagPrefix
outputs:
  - id: stub
    type:
      - 'null'
      - File
    doc: prefix stub for output BAM files (default behavior is to use input filename,
      without .bam extension, as stub). If input is stdin and no stub provided, a
      timestamp is generated as the stub.
    outputBinding:
      glob: $(inputs.stub)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
