cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - allele_calling
label: coreprofiler_allele_calling
doc: "Allele calling specific arguments.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: autotag_word_size
    type:
      - 'null'
      - int
    doc: Word size for Autotag BLASTn.
    inputBinding:
      position: 101
      prefix: --autotag_word_size
  - id: blast_db_path
    type:
      - 'null'
      - string
    doc: Path to the BLAST database.
    inputBinding:
      position: 101
      prefix: --blast_db_path
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: Return further information on incomplete alleles.
    inputBinding:
      position: 101
      prefix: --detailed
  - id: extract_cds_new_alleles
    type:
      - 'null'
      - boolean
    doc: Extract new alleles within CDS.
    inputBinding:
      position: 101
      prefix: -cds
  - id: min_cov_incomplete
    type:
      - 'null'
      - float
    doc: Minimum coverage perc to consider an allele incomplete (if --detailed 
      option).
    inputBinding:
      position: 101
      prefix: --min_cov_incomplete
  - id: min_cov_new_allele
    type:
      - 'null'
      - float
    doc: Minimum coverage perc to consider new alleles.
    inputBinding:
      position: 101
      prefix: --min_cov_new_allele
  - id: min_id_new_allele
    type:
      - 'null'
      - float
    doc: Minimum identity perc to consider new alleles.
    inputBinding:
      position: 101
      prefix: --min_id_new_allele
  - id: num_alleles_per_locus
    type:
      - 'null'
      - File
    doc: Tsv file containing the number of alleles per locus of a given scheme.
    inputBinding:
      position: 101
      prefix: --num_alleles_per_locus
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: profiles_w_tmp_alleles
    type:
      - 'null'
      - File
    doc: A JSON file containing info about files with temporary alleles.
    inputBinding:
      position: 101
      prefix: --profiles_w_tmp_alleles
  - id: query
    type:
      type: array
      items: File
    doc: Path(s) to query fasta file(s)
    inputBinding:
      position: 101
      prefix: --query
  - id: scheme_dir
    type: Directory
    doc: Path to scheme files.
    inputBinding:
      position: 101
      prefix: --scheme_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.out)
  - id: outfa
    type:
      - 'null'
      - File
    doc: Path to output fasta file with new alleles sequences if detected.
    outputBinding:
      glob: $(inputs.outfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
