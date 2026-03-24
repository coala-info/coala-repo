#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: samtools faidx

doc: samtools faidx - indexes or queries regions from a FASTA (or FASTQ) file, includes all extended options

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.21--h50ea8bc_0
  SoftwareRequirement:
    packages:
      samtools:
        version: ["1.21"]
        specs: ["identifiers.org/RRID:SCR_002105"]
  
baseCommand: ["samtools", "faidx"]

arguments:
  - valueFrom: $(inputs.fasta_file.basename).fai
    prefix: --output
    position: 2

inputs:
  fasta_file:
    type: File
    label: FASTA file
    doc: FASTA file
    inputBinding:
      position: 1
  length:
    type: int?
    label: Line wrapping length
    doc: Wrap sequence lines at given length; 0 means no wrapping. Defaults to line length in input file
    inputBinding:
      prefix: --length
  continue:
    type: boolean?
    label: Continue if region not found
    doc: If true, continue working if a non-existent region is requested.
    default: false
    inputBinding:
      prefix: --continue
  region_file:
    type: File?
    label: Region file
    doc: A file listing regions (chr:from-to) to extract.
    inputBinding:
      prefix: --region-file
  fastq:
    type: boolean?
    label: FASTQ mode
    doc: If true, treat the input as a FASTQ file and output in FASTQ format. This is the same as running samtools fqidx.
    default: false
    inputBinding:
      prefix: --fastq
  reverse_complement:
    type: boolean?
    label: Reverse complement
    doc: If true, output the reverse complement of the sequence. When turned on, "/rc" will be appended to sequence names.
    default: false
    inputBinding:
      prefix: --reverse-complement
  mark_strand:
    type: string?
    label: Mark strand option
    doc: |
      Append strand indicator to sequence name. Valid values:
        - "rc": Append '/rc' when writing the reverse complement (default)
        - "no": Do not append anything.
        - "sign": Append '(+)' for forward and '(-)' for reverse.
        - "custom,<pos>,<neg>": Append <pos> for forward and <neg> for reverse (allowing spaces if needed).
    inputBinding:
      prefix: --mark-strand
  fai_idx:
    type: File?
    label: FAI index file
    doc: Specify a FASTA index file to use or generate.
    inputBinding:
      prefix: --fai-idx
  gzi_idx:
    type: File?
    label: GZI index file
    doc: Specify a BGZF index file for compressed outputs.
    inputBinding:
      prefix: --gzi-idx
  output_fmt_option:
    type: string?
    label: output format option
    doc: Set output format options, e.g., 'level=5' for compression level (0-9).
    inputBinding:
      prefix: --output-fmt-option
  threads:
    type: int?
    label: number of CPU threads
    doc: Sets the number of extra threads for operations on compressed files.
    inputBinding:
      prefix: --threads

outputs:
  fasta_index:
    type: File
    label: output file
    doc: Indexed output fasta file in .fai format.
    outputBinding:
      glob: $(inputs.fasta_file.basename).fai

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-20"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"