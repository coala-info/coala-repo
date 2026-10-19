cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - bwt
label: rgi_rgi_bwt
doc: "Aligns metagenomic reads to CARD and wildCARD reference using kma, bowtie2 or
  bwa and provide reports.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: select read aligner (default=kma)
    inputBinding:
      position: 101
      prefix: --aligner
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary files (default=False)
    inputBinding:
      position: 101
      prefix: --clean
  - id: coverage
    type:
      - 'null'
      - string
    doc: filter reads based on coverage of reference sequence
    inputBinding:
      position: 101
      prefix: --coverage
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode (default=False)
    inputBinding:
      position: 101
      prefix: --debug
  - id: include_baits
    type:
      - 'null'
      - boolean
    doc: include baits (default=False)
    inputBinding:
      position: 101
      prefix: --include_baits
  - id: include_other_models
    type:
      - 'null'
      - boolean
    doc: include protein variant, rRNA variant, knockout, and protein 
      overexpression models (default=False)
    inputBinding:
      position: 101
      prefix: --include_other_models
  - id: include_wildcard
    type:
      - 'null'
      - boolean
    doc: include wildcard (default=False)
    inputBinding:
      position: 101
      prefix: --include_wildcard
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'use local database (default: uses database in executable directory)'
    inputBinding:
      position: 101
      prefix: --local
  - id: mapped
    type:
      - 'null'
      - string
    doc: filter reads based on mapped reads (default=False)
    inputBinding:
      position: 101
      prefix: --mapped
  - id: mapq
    type:
      - 'null'
      - string
    doc: filter reads based on MAPQ score (default=False)
    inputBinding:
      position: 101
      prefix: --mapq
  - id: read_one
    type: File
    doc: raw read one (qc and trimmed)
    inputBinding:
      position: 101
      prefix: --read_one
  - id: read_two
    type:
      - 'null'
      - File
    doc: raw read two (qc and trimmed)
    inputBinding:
      position: 101
      prefix: --read_two
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use (default=20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_file_path
    type: string
    inputBinding:
      position: 102
      prefix: --output_file
  - id: local_db
    type:
      - 'null'
      - Directory
    doc: Local database directory created by rgi load --local (staged as localDB in the working directory).
outputs:
  - id: output_file
    type:
      type: array
      items: File
    doc: Mapping reports (allele, gene, overall, reference and artifact statistics) and the sorted BAM file
    outputBinding:
      glob:
        - $(inputs.output_file_path).allele_mapping_data.txt
        - $(inputs.output_file_path).allele_mapping_data.json
        - $(inputs.output_file_path).gene_mapping_data.txt
        - $(inputs.output_file_path).overall_mapping_stats.txt
        - $(inputs.output_file_path).reference_mapping_stats.txt
        - $(inputs.output_file_path).artifacts_mapping_stats.txt
        - $(inputs.output_file_path).sorted.length_100.bam
        - $(inputs.output_file_path).sorted.length_100.bam.bai
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.local_db ? [{entry: inputs.local_db, entryname: 'localDB', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
