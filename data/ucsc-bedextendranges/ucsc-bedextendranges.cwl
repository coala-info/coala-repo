cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedExtendRanges
label: ucsc-bedextendranges
doc: "Extend length of entries in bed 6+ data to be at least the given length, taking\
  \ strand directionality into account. The chromosome sizes are read from a UCSC\
  \ MySQL database, so the tool needs network access.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
stdout: $(inputs.output_name)
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg18, hg19, mm10) to fetch chromosome sizes.
    inputBinding:
      position: 11
  - id: length
    type: int
    doc: Minimum length of the entries after extension.
    inputBinding:
      position: 12
  - id: input_beds
    type:
      type: array
      items: File
    doc: The input BED file(s) (bed 6+).
    inputBinding:
      position: 13
  - id: host
    type: ['null', string]
    default: genome-mysql.soe.ucsc.edu
    doc: MySQL host
    inputBinding:
      position: 1
      prefix: -host=
      separate: false
  - id: user
    type: ['null', string]
    default: genome
    doc: MySQL user
    inputBinding:
      position: 2
      prefix: -user=
      separate: false
  - id: password
    type: ['null', string]
    doc: MySQL password
    inputBinding:
      position: 3
      prefix: -password=
      separate: false
  - id: tab
    type: ['null', boolean]
    doc: Separate by tabs rather than space
    inputBinding:
      position: 4
      prefix: -tab
  - id: verbose
    type: ['null', int]
    doc: Verbose level for extra information to STDERR
    inputBinding:
      position: 5
      prefix: -verbose=
      separate: false
  - id: output_name
    type: ['null', string]
    default: extended.bed
    doc: Name of the output file (standard output of the tool)
outputs:
  - id: output_bed
    type: File
    doc: The output BED file with extended ranges.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedextendranges:482--h0b57e2e_0
