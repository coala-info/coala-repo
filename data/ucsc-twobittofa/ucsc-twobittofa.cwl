cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitToFa
label: ucsc-twobittofa
doc: Convert all or part of .2bit file to fasta
inputs:
  - id: input_two_bit
    type: File
    doc: input .2bit file (or URL)
    inputBinding:
      position: 1
  - id: output_fa
    type: string
    doc: output fasta file
    inputBinding:
      position: 2
  - id: seq
    type:
      - 'null'
      - string
    doc: Restrict this to just one sequence.
    inputBinding:
      position: 103
      prefix: -seq=
      separate: false
  - id: start
    type:
      - 'null'
      - int
    doc: Start at given position in sequence (zero-based).
    inputBinding:
      position: 103
      prefix: -start=
      separate: false
  - id: end
    type:
      - 'null'
      - int
    doc: End at given position in sequence (non-inclusive).
    inputBinding:
      position: 103
      prefix: -end=
      separate: false
  - id: seq_list
    type:
      - 'null'
      - File
    doc: File containing list of the desired sequence names in the format 
      seqSpec[:start-end], e.g. chr1 or chr1:0-189 where coordinates are 
      half-open zero-based, i.e. [start,end).
    inputBinding:
      position: 103
      prefix: -seqList=
      separate: false
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Convert sequence to all upper case.
    inputBinding:
      position: 103
      prefix: -noMask
  - id: bpt
    type:
      - 'null'
      - File
    doc: Use bpt index instead of built-in one.
    inputBinding:
      position: 103
      prefix: -bpt=
      separate: false
  - id: bed
    type:
      - 'null'
      - File
    doc: Grab sequences specified by input.bed. Will exclude introns.
    inputBinding:
      position: 103
      prefix: -bed=
      separate: false
  - id: bed_pos
    type:
      - 'null'
      - boolean
    doc: With -bed, use chrom:start-end as the fasta ID in output.fa.
    inputBinding:
      position: 103
      prefix: -bedPos
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: Place to put cache for remote bigBed/bigWigs.
    inputBinding:
      position: 103
      prefix: -udcDir=
      separate: false
outputs:
  - id: out_output_fa
    type: File
    doc: output fasta file
    outputBinding:
      glob: $(inputs.output_fa)
  - id: output_udc_dir
    type:
      - 'null'
      - Directory
    doc: Place to put cache for remote bigBed/bigWigs.
    outputBinding:
      glob: $(inputs.udc_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobittofa:482--hdc0a859_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
