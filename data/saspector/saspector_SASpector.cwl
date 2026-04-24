cwlVersion: v1.2
class: CommandLineTool
baseCommand: SASpector
label: saspector_SASpector
doc: "Short-read Assembly inSpector\n\nTool homepage: https://github.com/alejocrojo09/SASpector"
inputs:
  - id: coverage_bam_file
    type:
      - 'null'
      - File
    doc: Run SAMtools bedcov to look at short-read coverage in the missing 
      regions.Needs alignment of reads to the reference genome in BAM format
    inputBinding:
      position: 101
      prefix: --coverage
  - id: draft_contigs_fasta
    type: File
    doc: Illumina FASTA file as contigs/draft genome
    inputBinding:
      position: 101
      prefix: --draft
  - id: flanking_length_bp
    type:
      - 'null'
      - int
    doc: Add flanking regions
    inputBinding:
      position: 101
      prefix: --flanking
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force output directory overwrite
    inputBinding:
      position: 101
      prefix: --force
  - id: k_size
    type:
      - 'null'
      - int
    doc: Sourmash analysis
    inputBinding:
      position: 101
      prefix: --kmers
  - id: mash_sketch_file
    type:
      - 'null'
      - File
    doc: Automatic selection of genome amongst RefSeq 2020 database (complete 
      genomes) /!\ Experimental feature!
    inputBinding:
      position: 101
      prefix: --mash_selection
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set the prefix of the files, use for example the strain name
    inputBinding:
      position: 101
      prefix: --prefix
  - id: protein_fasta_file
    type:
      - 'null'
      - File
    doc: BLAST protein database FASTA file
    inputBinding:
      position: 101
      prefix: --proteindb
  - id: quast
    type:
      - 'null'
      - boolean
    doc: Run QUAST for unmapped regions against reference assembly
    inputBinding:
      position: 101
      prefix: --quast
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Completed assembly FASTA file as reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: tandem_repeats
    type:
      - 'null'
      - boolean
    doc: Run tandem repeat finder within missing regions
    inputBinding:
      position: 101
      prefix: --tandem_repeats
outputs:
  - id: output_path
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saspector:0.0.5--pyhdfd78af_0
