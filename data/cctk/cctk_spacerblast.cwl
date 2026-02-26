cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk_spacerblast
label: cctk_spacerblast
doc: "Finds protospacers in a blast database that match a given set of spacers.\n\n\
  Tool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: size of batch to submit to blastdbcmd.
    default: 1000
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: blastdb
    type: string
    doc: path to blast db excluding extension
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: downstream
    type:
      - 'null'
      - int
    doc: number of bases to return from the 3'side of protospacers
    inputBinding:
      position: 101
      prefix: --downstream
  - id: evalue
    type:
      - 'null'
      - float
    doc: blast e value.
    default: 10
    inputBinding:
      position: 101
      prefix: --evalue
  - id: flanking
    type:
      - 'null'
      - int
    doc: number of bases to return from both sides of protospacers
    inputBinding:
      position: 101
      prefix: --flanking
  - id: mask_regions
    type:
      - 'null'
      - File
    doc: file in bed format listing regions to ignore
    inputBinding:
      position: 101
      prefix: --mask-regions
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: blast max target seqs.
    default: 10000
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: other_options
    type:
      - 'null'
      - string
    doc: 'additional blastn options. Forbidden options: blastn -query -db -task -outfmt
      -num_threads -max_target_seqs -evalue'
    inputBinding:
      position: 101
      prefix: --other-options
  - id: pam
    type:
      - 'null'
      - string
    doc: nucleotide pattern describing the PAM sequence e.g. NNNCC
    inputBinding:
      position: 101
      prefix: --pam
  - id: pam_location
    type:
      - 'null'
      - string
    doc: PAM location relative to protospacer
    inputBinding:
      position: 101
      prefix: --pam-location
  - id: percent_id
    type:
      - 'null'
      - float
    doc: minimum percent identity between spacer and protospacer
    inputBinding:
      position: 101
      prefix: --percent-id
  - id: regex_pam
    type:
      - 'null'
      - string
    doc: regex describing the PAM sequence
    inputBinding:
      position: 101
      prefix: --regex-pam
  - id: seed_region
    type:
      - 'null'
      - string
    doc: "Specify part of protospacer in which mismatches should not be tolerated.
      Format: start:stop, 0-base coordinates, 5':3'. E.g., \"0:6\" or \":6\" specifies
      first 6 bases (0,1,2,3,4,5). \"-6:-1\" or \"-6:\" specifies last 6 bases."
    inputBinding:
      position: 101
      prefix: --seed-region
  - id: spacers
    type: File
    doc: spacers in fasta format
    inputBinding:
      position: 101
      prefix: --spacers
  - id: threads
    type:
      - 'null'
      - int
    doc: threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: upstream
    type:
      - 'null'
      - int
    doc: number of bases to return from the 5'side of protospacers
    inputBinding:
      position: 101
      prefix: --upstream
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: path to output file.
    outputBinding:
      glob: $(inputs.out)
  - id: no_pam_out
    type:
      - 'null'
      - File
    doc: path to output file for protospacers with no PAM, if desired
    outputBinding:
      glob: $(inputs.no_pam_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
