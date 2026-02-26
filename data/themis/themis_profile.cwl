cwlVersion: v1.2
class: CommandLineTool
baseCommand: themis profile
label: themis_profile
doc: "Profile microbial communities using a compressed de Bruijn graph.\n\nTool homepage:
  https://github.com/xujialupaoli/Themis"
inputs:
  - id: db_prefix
    type: string
    doc: Database input prefix.
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size used in the ccDBG-based profiling step.
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: reads
    type:
      type: array
      items: File
    doc: 'For paired-end data, specify mates consecutively: -r R1.fq -r R2.fq. For
      single-end data, use --single and give one -r per file.'
    inputBinding:
      position: 101
      prefix: --reads
  - id: ref_info
    type: File
    doc: 'Tab-separated reference metadata file. Fields: strain_name <tab> strain_taxid
      <tab> species_taxid <tab> species_name <tab> genome_path. strain_name and strain_taxid
      must be unique.'
    inputBinding:
      position: 101
      prefix: --ref-info
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Treat input as single-end reads.
    inputBinding:
      position: 101
      prefix: --single
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for profiling results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
