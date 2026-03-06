cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - pairtobed
label: bedtools_pairtobed
doc: Report overlaps between a BEDPE file and a BED/GFF/VCF file.
inputs:
  - id: abam
    type: File
    doc: The A input file is in BAM format. Output will be BAM as well. Replaces
      -a.
    inputBinding:
      position: 101
      prefix: -abam
  - id: bedpe_file
    type:
      - 'null'
      - File
    doc: The A input file in BEDPE format.
    inputBinding:
      position: 101
      prefix: -a
  - id: bedpe_output
    type:
      - 'null'
      - boolean
    doc: When using BAM input (-abam), write output as BEDPE. The default is to 
      write output in BAM when using -abam.
    inputBinding:
      position: 101
      prefix: -bedpe
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness when finding overlaps. Default is to 
      ignore strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: Use BAM total edit distance (NM tag) for BEDPE score.
    inputBinding:
      position: 101
      prefix: -ed
  - id: min_overlap_fraction
    type: float
    doc: Minimum overlap required as fraction of A (e.g. 0.05).
    inputBinding:
      position: 101
      prefix: -f
  - id: overlap_file
    type:
      - 'null'
      - File
    doc: The B input file (BED/GFF/VCF format).
    inputBinding:
      position: 101
      prefix: -b
  - id: overlap_type
    type:
      - 'null'
      - string
    doc: Approach to reporting overlaps between BEDPE and BED (either, neither, 
      both, xor, notboth, ispan, ospan, notispan, notospan).
    inputBinding:
      position: 101
      prefix: -type
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness when finding overlaps. Default is to ignore 
      strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_pairtobed.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
