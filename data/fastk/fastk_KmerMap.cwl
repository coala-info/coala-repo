cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerMap
label: fastk_KmerMap
doc: "Produces a BED file of all the regions of target sequences covered by the k-mers of a k-mer table.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: $(inputs.table.basename)
  - position: 101
    valueFrom: $(inputs.target.basename)
  - position: 102
    valueFrom: $(inputs.out_prefix)
inputs:
  - id: table
    type: File
    doc: k-mer table stub file (.ktab) made by FastK.
  - id: table_parts
    type: File[]
    doc: 'Hidden table part files (.<name>.ktab.N) made by FastK; they are staged beside the stub.'
  - id: target
    type: File
    doc: Target sequences (DNA FASTA).
  - id: out_prefix
    type: string
    doc: 'Output name prefix <out>; the BED file is <out>.<target>.kmers.bed, or <out>.<target>.kmers.merge.bed with merge.'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output to stderr.
    inputBinding:
      position: 50
      prefix: '-v'
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge overlapping k-mer hits.
    inputBinding:
      position: 50
      prefix: '-m'
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use -T threads. [default: 4]'
    inputBinding:
      position: 50
      prefix: '-T'
      separate: false
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Place all temporary files in directory -P. [default: /tmp]'
    inputBinding:
      position: 50
      prefix: '-P'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bed
    type: File
    doc: BED file of k-mer hits.
    outputBinding:
      glob: '$(inputs.out_prefix).*.bed'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.table)
      - $(inputs.table_parts)
      - $(inputs.target)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_KmerMap.out
