cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedItemOverlapCount
label: ucsc-beditemoverlapcount
doc: "Count number of times a base is overlapped by the items in a bed file. Output
  is bedGraph 4 to stdout. The bed file is read from standard input and must be sorted
  by chrom. A database name is required, even when -chromSize is used.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
stdin: $(inputs.input_bed.path)
stdout: $(inputs.out_bedgraph)
arguments:
  - position: 2
    valueFrom: stdin
inputs:
  - id: database
    type: string
    doc: UCSC database name used to look up chromosome sizes (not used when -chromSize
      is given, but must be present).
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: Input BED file, sorted by chrom (sent to the program on stdin).
  - id: out_bedgraph
    type: string
    doc: Name of the output bedGraph file (standard output).
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Add blocks with zero count, normally these are omitted.
    inputBinding:
      position: 0
      prefix: -zero
  - id: bed12
    type:
      - 'null'
      - boolean
    doc: Expect bed12 and count based on blocks. Without this option only the first
      three fields are used.
    inputBinding:
      position: 0
      prefix: -bed12
  - id: max
    type:
      - 'null'
      - boolean
    doc: If counts per base overflows set to max (4294967295) instead of exiting.
    inputBinding:
      position: 0
      prefix: -max
  - id: out_bounds
    type:
      - 'null'
      - boolean
    doc: Output min/max to stderr.
    inputBinding:
      position: 0
      prefix: -outBounds
  - id: chrom_size
    type:
      - 'null'
      - File
    doc: Read chrom sizes from this file instead of the database (two white space
      separated fields per line, chrom name and size).
    inputBinding:
      position: 0
      prefix: -chromSize=
      separate: false
  - id: host
    type:
      - 'null'
      - string
    doc: MySQL host used to get chrom sizes.
    inputBinding:
      position: 0
      prefix: -host=
      separate: false
  - id: user
    type:
      - 'null'
      - string
    doc: MySQL user.
    inputBinding:
      position: 0
      prefix: -user=
      separate: false
  - id: password
    type:
      - 'null'
      - string
    doc: MySQL password.
    inputBinding:
      position: 0
      prefix: -password=
      separate: false
outputs:
  - id: output_bedgraph
    type: File
    doc: bedGraph with the overlap count of each base.
    outputBinding:
      glob: $(inputs.out_bedgraph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-beditemoverlapcount:482--h0b57e2e_0
