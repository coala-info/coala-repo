cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - nuc
label: bedtools_nuc
doc: Profiles the nucleotide content of intervals in a fasta file.
inputs:
  - id: bed_file
    type: File
    doc: BED/GFF/VCF file of ranges to extract from -fi
    inputBinding:
      position: 101
      prefix: -bed
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -fi
  - id: full_header
    type:
      - 'null'
      - boolean
    doc: Use full fasta header. By default, only the word before the first space
      or tab is used.
    inputBinding:
      position: 101
      prefix: -fullHeader
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when matching -pattern. By defaulty, case matters.
    inputBinding:
      position: 101
      prefix: -C
  - id: pattern
    type:
      - 'null'
      - string
    doc: Report the number of times a user-defined sequence is observed 
      (case-sensitive).
    inputBinding:
      position: 101
      prefix: -pattern
  - id: print_sequence
    type:
      - 'null'
      - boolean
    doc: Print the extracted sequence
    inputBinding:
      position: 101
      prefix: -seq
  - id: strand_profile
    type:
      - 'null'
      - boolean
    doc: Profile the sequence according to strand.
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_nuc.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
