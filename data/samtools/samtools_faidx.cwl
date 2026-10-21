cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- faidx
label: samtools_faidx
doc: 'Index or extract regions of a FASTA file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.input_file)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input FASTA file (optionally bgzip compressed); staged so the index can be written.
  inputBinding:
    position: 104
- id: regions
  type:
  - 'null'
  - type: array
    items: string
  doc: Regions to extract (chr:from-to); none means only build the index.
  inputBinding:
    position: 105
- id: output_filename
  type:
  - 'null'
  - string
  doc: Write the extracted FASTA to this file (-o); needed when regions are given.
  inputBinding:
    position: 103
    prefix: -o
- id: length
  type:
  - 'null'
  - int
  doc: Length of FASTA sequence line [60].
  inputBinding:
    position: 103
    prefix: --length
- id: continue
  type:
  - 'null'
  - boolean
  doc: Continue after trying to retrieve missing region.
  inputBinding:
    position: 103
    prefix: --continue
- id: region_file
  type:
  - 'null'
  - File
  doc: File of regions, format chr:from-to, one per line.
  inputBinding:
    position: 103
    prefix: --region-file
- id: reverse_complement
  type:
  - 'null'
  - boolean
  doc: Reverse complement sequences.
  inputBinding:
    position: 103
    prefix: --reverse-complement
- id: mark_strand
  type:
  - 'null'
  - string
  doc: 'Add strand indicator to sequence name: rc, no, sign or custom,<pos>,<neg>.'
  inputBinding:
    position: 103
    prefix: --mark-strand
- id: fai_idx
  type:
  - 'null'
  - string
  doc: Name of the index file (default file.fa.fai).
  inputBinding:
    position: 103
    prefix: --fai-idx
- id: gzi_idx
  type:
  - 'null'
  - string
  doc: Name of compressed file index (default file.gz.gzi).
  inputBinding:
    position: 103
    prefix: --gzi-idx
- id: fastq
  type:
  - 'null'
  - boolean
  doc: File and index in FASTQ format.
  inputBinding:
    position: 103
    prefix: --fastq
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output file.
  inputBinding:
    position: 103
    prefix: --write-index
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
outputs:
- id: output
  type:
  - 'null'
  - File
  doc: Extracted sequences.
  outputBinding:
    glob: $(inputs.output_filename)
- id: fai_output
  type:
  - 'null'
  - File
  doc: Sequence index.
  outputBinding:
    glob:
    - '$(inputs.fai_idx ? inputs.fai_idx : inputs.input_file.basename + ''.fai'')'
- id: gzi_output
  type:
  - 'null'
  - File
  doc: Index of the compressed file.
  outputBinding:
    glob:
    - '$(inputs.gzi_idx ? inputs.gzi_idx : inputs.input_file.basename + ''.gzi'')'
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the extracted file when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).fai
    - $(inputs.output_filename).gzi
