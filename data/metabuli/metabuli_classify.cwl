cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - classify
label: metabuli_classify
doc: "Assign taxonomic labels to query reads.\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory)
        entry: '$({class: "Directory", listing: []})'
        writable: true
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: "Query file(s): one file for single-end or long reads, two files for paired-end reads"
    inputBinding:
      position: 1
  - id: database_directory
    type: Directory
    doc: "Database directory"
    inputBinding:
      position: 2
  - id: output_directory
    type: string
    doc: "Output directory (created before the run)"
    inputBinding:
      position: 3
  - id: job_id
    type: string
    doc: "Job ID, the prefix of the output files"
    inputBinding:
      position: 4
  - id: mask
    type: 
      - 'null'
      - int
    doc: "Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]"
    inputBinding:
      position: 10
      prefix: --mask
  - id: mask_prob
    type: 
      - 'null'
      - float
    doc: "Mask sequences if probability is above threshold [0.900]"
    inputBinding:
      position: 11
      prefix: --mask-prob
  - id: seq_mode
    type: 
      - 'null'
      - int
    doc: "Single-end: 1, Paired-end: 2, Long read: 3 [2]"
    inputBinding:
      position: 12
      prefix: --seq-mode
  - id: min_score
    type: 
      - 'null'
      - float
    doc: "Min. sequence similarity score (0.0-1.0) [0.000]"
    inputBinding:
      position: 13
      prefix: --min-score
  - id: min_cov
    type: 
      - 'null'
      - float
    doc: "Min. query coverage (0.0-1.0) [0.000]"
    inputBinding:
      position: 14
      prefix: --min-cov
  - id: min_cons_cnt
    type: 
      - 'null'
      - int
    doc: "Min. number of consecutive matches for prokaryote/virus classification [4]"
    inputBinding:
      position: 15
      prefix: --min-cons-cnt
  - id: min_cons_cnt_euk
    type: 
      - 'null'
      - int
    doc: "Min. number of consecutive matches for eukaryote classification [9]"
    inputBinding:
      position: 16
      prefix: --min-cons-cnt-euk
  - id: min_sp_score
    type: 
      - 'null'
      - float
    doc: "Min. score for species- or lower-level classification [0.000]"
    inputBinding:
      position: 17
      prefix: --min-sp-score
  - id: hamming_margin
    type: 
      - 'null'
      - int
    doc: "It allows extra Hamming distance than the minimum distance [0]"
    inputBinding:
      position: 18
      prefix: --hamming-margin
  - id: taxonomy_path
    type: 
      - 'null'
      - Directory
    doc: "Directory where the taxonomy dump files are stored"
    inputBinding:
      position: 100
      prefix: --taxonomy-path
  - id: max_ram
    type: 
      - 'null'
      - int
    doc: "RAM usage in GiB [128]"
    inputBinding:
      position: 100
      prefix: --max-ram
  - id: match_per_kmer
    type: 
      - 'null'
      - int
    doc: "Num. of matches per query k-mer. Larger values assign more memory for storing k-mer matches [4]"
    inputBinding:
      position: 21
      prefix: --match-per-kmer
  - id: accession_level
    type: 
      - 'null'
      - int
    doc: "Build or search a database for accession-level classification [0]"
    inputBinding:
      position: 22
      prefix: --accession-level
  - id: tie_ratio
    type: 
      - 'null'
      - float
    doc: "Best * --tie-ratio is considered as a tie [0.950]"
    inputBinding:
      position: 23
      prefix: --tie-ratio
  - id: skip_redundancy
    type: 
      - 'null'
      - int
    doc: "Not storing k-mer's redundancy [0]"
    inputBinding:
      position: 24
      prefix: --skip-redundancy
  - id: lineage
    type: 
      - 'null'
      - int
    doc: "Print lineage information [0]"
    inputBinding:
      position: 25
      prefix: --lineage
  - id: validate_input
    type: 
      - 'null'
      - int
    doc: "Validate format of input FASTA/FASTQ file(s) [0]"
    inputBinding:
      position: 26
      prefix: --validate-input
  - id: validate_db
    type: 
      - 'null'
      - int
    doc: "Validate the database: checks if all required files are present and if the k-mer count is consistent [0]"
    inputBinding:
      position: 27
      prefix: --validate-db
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 100
      prefix: --threads
outputs:
  - id: results
    type: Directory
    doc: "Output directory with <job ID>_classifications.tsv, <job ID>_report.tsv and <job ID>_krona.html"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_classify.out
