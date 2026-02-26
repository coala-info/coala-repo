cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - query
label: seqforge_query
doc: "Run BLAST queries in parallel.\n\nTool homepage: https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: database
    type: Directory
    doc: Path to the BLAST databases.
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value threshold.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_directory
    type:
      - 'null'
      - Directory
    doc: Path to FASTA file or directory of FASTA files used to create the BLAST
      databases. Required if using --motif
    inputBinding:
      position: 101
      prefix: --fasta-directory
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary *_results.txt files in the output directory
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Define query coverage threshold (default = 75)
    default: 75
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_perc
    type:
      - 'null'
      - float
    doc: Define percent identity threshold (default = 90)
    default: 90
    inputBinding:
      position: 101
      prefix: --min-perc
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: Minimum sequence length for database searches (use with caution)
    inputBinding:
      position: 101
      prefix: --min-seq-len
  - id: motif
    type:
      - 'null'
      - type: array
        items: string
    doc: "Amino acid motif (e.g., GHXXGE) to search within blast hits. X is treated
      as a wildcard. For use only with blastp queries Motifs may be linked to specific
      query results using braces. For example: 'query_file.faa' --> '--motif GHXXGE{query_file}'"
    inputBinding:
      position: 101
      prefix: --motif
  - id: motif_fasta_out
    type:
      - 'null'
      - boolean
    doc: Export motif match source gene as FASTA file(s)
    inputBinding:
      position: 101
      prefix: --motif-fasta-out
  - id: motif_only
    type:
      - 'null'
      - boolean
    doc: For use with --motif-fasta-out, output only the motif string
    inputBinding:
      position: 101
      prefix: --motif-only
  - id: no_alignment_files
    type:
      - 'null'
      - boolean
    doc: Do not generate BLAST alignment output files.
    inputBinding:
      position: 101
      prefix: --no-alignment-files
  - id: nucleotide_query
    type:
      - 'null'
      - boolean
    doc: Use blastn for nucelotide queries
    inputBinding:
      position: 101
      prefix: --nucleotide-query
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output figure to PDF instead of PNG
    inputBinding:
      position: 101
      prefix: --pdf
  - id: progress
    type:
      - 'null'
      - string
    doc: Progress reporting mode passing only --progress is equivalent to 
      --progress bar 'verbose' prints a line per item, 'none' silences output
    inputBinding:
      position: 101
      prefix: --progress
  - id: query_files
    type: File
    doc: Path to the query files in FASTA format.
    inputBinding:
      position: 101
      prefix: --query-files
  - id: report_strongest_matches
    type:
      - 'null'
      - boolean
    doc: Report only the top hit for each query
    inputBinding:
      position: 101
      prefix: --report-strongest-matches
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Specify a temporary directory (default = /tmp/)
    default: /tmp/
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores to dedicate
    inputBinding:
      position: 101
      prefix: --threads
  - id: visualize
    type:
      - 'null'
      - boolean
    doc: visualize query results
    inputBinding:
      position: 101
      prefix: --visualize
outputs:
  - id: output_dir
    type: Directory
    doc: Path to directory to store results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
