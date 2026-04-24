cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_consensus
label: smallgenomeutilities_extract_consensus
doc: "Script to construct consensus sequences\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: ambiguous_n_read_count
    type:
      - 'null'
      - int
    doc: Read count below which ambiguous base 'n' is reported
    inputBinding:
      position: 101
      prefix: -n
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Fasta file containing the reference sequence
    inputBinding:
      position: 101
      prefix: -f
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: min_ambiguous_freq
    type:
      - 'null'
      - float
    doc: Minimum frequency for an ambiguous nucleotide
    inputBinding:
      position: 101
      prefix: -a
  - id: min_phred_quality
    type:
      - 'null'
      - int
    doc: Minimum phred quality score a base has to reach to be counted
    inputBinding:
      position: 101
      prefix: -q
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth for reporting variants per locus
    inputBinding:
      position: 101
      prefix: -c
  - id: patient_identifier
    type:
      - 'null'
      - string
    doc: Patient/sample identifier
    inputBinding:
      position: 101
      prefix: -N
  - id: region
    type:
      - 'null'
      - string
    doc: Region of interested in BED format, e.g. HXB2:2253-3869. Loci are 
      interpreted using 0-based indexing, and a half-open interval is used, i.e,
      [start:end)
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
