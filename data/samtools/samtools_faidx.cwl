cwlVersion: v1.2
class: CommandLineTool
label: samtools_faidx
doc: "Index or extract regions from FASTA/FASTQ files\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.input_file.basename)
    entry: $(inputs.input_file)
- class: InlineJavascriptRequirement
baseCommand:
- samtools
- faidx
inputs:
- id: input_file
  type: File
  doc: Input FASTA or FASTQ file (can be gzipped)
  inputBinding:
    position: 1
    valueFrom: $(self.basename)
- id: regions
  type:
  - 'null'
  - type: array
    items: string
  doc: 'Regions to extract (format: chr:from-to)'
  inputBinding:
    position: 2
- id: continue
  type:
  - 'null'
  - boolean
  doc: Continue after trying to retrieve missing region.
  inputBinding:
    position: 103
    prefix: --continue
- id: fai_idx
  type:
  - 'null'
  - File
  doc: name of the index file (default file.fa.fai).
  inputBinding:
    position: 103
    prefix: --fai-idx
- id: fastq
  type:
  - 'null'
  - boolean
  doc: File and index in FASTQ format.
  inputBinding:
    position: 103
    prefix: --fastq
- id: gzi_idx
  type:
  - 'null'
  - File
  doc: name of compressed file index (default file.fa.gz.gzi).
  inputBinding:
    position: 103
    prefix: --gzi-idx
- id: length
  type:
  - 'null'
  - int
  doc: Length of FASTA sequence line.
  inputBinding:
    position: 103
    prefix: --length
- id: mark_strand
  type:
  - 'null'
  - string
  doc: Add strand indicator to sequence name (TYPE = rc, no, sign, or 
    custom,<pos>,<neg>)
  inputBinding:
    position: 103
    prefix: --mark-strand
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 103
    prefix: --output-fmt-option
- id: region_file
  type:
  - 'null'
  - File
  doc: File of regions. Format is chr:from-to. One per line.
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
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  inputBinding:
    position: 103
    prefix: --threads
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output files
  inputBinding:
    position: 103
    prefix: --write-index
outputs:
- id: output_fai
  type: File
  doc: The generated FASTA index file.
  outputBinding:
    glob: "*.fai"
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
