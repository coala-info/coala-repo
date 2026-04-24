cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngmlr
label: ngmlr
doc: "ngmlr 0.2.7 (build: Jul  2 2018 10:32:15, start: 2026-02-26.16:20:07)\n\nTool
  homepage: https://github.com/philres/ngmlr"
inputs:
  - id: bam_fix
    type:
      - 'null'
      - boolean
    doc: Report reads with > 64k CIGAR operations as unmapped. Required to be 
      compatibel to BAM format
    inputBinding:
      position: 101
      prefix: --bam-fix
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Sets the size of the grid used during candidate search
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: gap_decay
    type:
      - 'null'
      - float
    doc: Gap extend decay
    inputBinding:
      position: 101
      prefix: --gap-decay
  - id: gap_extend_max
    type:
      - 'null'
      - float
    doc: Gap open extend max
    inputBinding:
      position: 101
      prefix: --gap-extend-max
  - id: gap_extend_min
    type:
      - 'null'
      - float
    doc: Gap open extend min
    inputBinding:
      position: 101
      prefix: --gap-extend-min
  - id: gap_open
    type:
      - 'null'
      - float
    doc: Gap open score
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length in bases
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: kmer_skip
    type:
      - 'null'
      - int
    doc: Number of k-mers to skip when building the lookup table from the 
      reference
    inputBinding:
      position: 101
      prefix: --kmer-skip
  - id: match
    type:
      - 'null'
      - float
    doc: Match score
    inputBinding:
      position: 101
      prefix: --match
  - id: max_segments
    type:
      - 'null'
      - int
    doc: Max number of segments allowed for a read per kb
    inputBinding:
      position: 101
      prefix: --max-segments
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Alignments with an identity lower than this threshold will be discarded
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: min_residues
    type:
      - 'null'
      - float
    doc: Alignments containing less than <int> or (<float> * read length) 
      residues will be discarded
    inputBinding:
      position: 101
      prefix: --min-residues
  - id: mismatch
    type:
      - 'null'
      - float
    doc: Mismatch score
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: no_lowqualitysplit
    type:
      - 'null'
      - boolean
    doc: Split alignments with poor quality
    inputBinding:
      position: 101
      prefix: --no-lowqualitysplit
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Don't print progress info while mapping
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: no_smallinv
    type:
      - 'null'
      - boolean
    doc: Don't detect small inversions
    inputBinding:
      position: 101
      prefix: --no-smallinv
  - id: presets
    type:
      - 'null'
      - string
    doc: Parameter presets for different sequencing technologies
    inputBinding:
      position: 101
      prefix: --presets
  - id: query
    type: File
    doc: Path to the read file (FASTA/Q)
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    doc: Path to the reference genome (FASTA/Q, can be gzipped)
    inputBinding:
      position: 101
      prefix: --reference
  - id: rg_cn
    type:
      - 'null'
      - string
    doc: 'RG header: sequencing center'
    inputBinding:
      position: 101
      prefix: --rg-cn
  - id: rg_ds
    type:
      - 'null'
      - string
    doc: 'RG header: Description'
    inputBinding:
      position: 101
      prefix: --rg-ds
  - id: rg_dt
    type:
      - 'null'
      - string
    doc: 'RG header: Date (format: YYYY-MM-DD)'
    inputBinding:
      position: 101
      prefix: --rg-dt
  - id: rg_fo
    type:
      - 'null'
      - string
    doc: 'RG header: Flow order'
    inputBinding:
      position: 101
      prefix: --rg-fo
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Adds RG:Z:<string> to all alignments in SAM/BAM
    inputBinding:
      position: 101
      prefix: --rg-id
  - id: rg_ks
    type:
      - 'null'
      - string
    doc: 'RG header: Key sequence'
    inputBinding:
      position: 101
      prefix: --rg-ks
  - id: rg_lb
    type:
      - 'null'
      - string
    doc: 'RG header: Library'
    inputBinding:
      position: 101
      prefix: --rg-lb
  - id: rg_pg
    type:
      - 'null'
      - string
    doc: 'RG header: Programs'
    inputBinding:
      position: 101
      prefix: --rg-pg
  - id: rg_pi
    type:
      - 'null'
      - string
    doc: 'RG header: Median insert size'
    inputBinding:
      position: 101
      prefix: --rg-pi
  - id: rg_pl
    type:
      - 'null'
      - string
    doc: 'RG header: Platform'
    inputBinding:
      position: 101
      prefix: --rg-pl
  - id: rg_pu
    type:
      - 'null'
      - string
    doc: 'RG header: Platform unit'
    inputBinding:
      position: 101
      prefix: --rg-pu
  - id: rg_sm
    type:
      - 'null'
      - string
    doc: 'RG header: Sample'
    inputBinding:
      position: 101
      prefix: --rg-sm
  - id: skip_write
    type:
      - 'null'
      - boolean
    doc: Don't write reference index to disk
    inputBinding:
      position: 101
      prefix: --skip-write
  - id: subread_corridor
    type:
      - 'null'
      - int
    doc: Length of corridor sub-reads are aligned with
    inputBinding:
      position: 101
      prefix: --subread-corridor
  - id: subread_length
    type:
      - 'null'
      - int
    doc: Length of fragments reads are split into
    inputBinding:
      position: 101
      prefix: --subread-length
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Adds RG:Z:<string> to all alignments in SAM/BAM
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmlr:0.2.7--he941832_0
