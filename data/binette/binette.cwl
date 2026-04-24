cwlVersion: v1.2
class: CommandLineTool
baseCommand: binette
label: binette
doc: "Binette 1.2.1: fast and accurate binning refinement tool to constructs high
  quality MAGs from the output of multiple binning tools.\n\nTool homepage: https://github.com/genotoul-bioinfo/binette"
inputs:
  - id: bin_dirs
    type:
      - 'null'
      - Directory
    doc: List of bin folders containing each bin in a fasta file.
    inputBinding:
      position: 101
      prefix: --bin_dirs
  - id: checkm2_db
    type:
      - 'null'
      - Directory
    doc: Path to CheckM2 diamond database. By default the database set via 
      <checkm2 database> is used.
    inputBinding:
      position: 101
      prefix: --checkm2_db
  - id: contamination_weight
    type:
      - 'null'
      - float
    doc: 'Bins are scored as: completeness - weight * contamination. A lower weight
      favors completeness over low contamination.'
    inputBinding:
      position: 101
      prefix: --contamination_weight
  - id: contig2bin_tables
    type:
      - 'null'
      - File
    doc: 'List of contig2bin tables with two columns: contig, bin.'
    inputBinding:
      position: 101
      prefix: --contig2bin_tables
  - id: contigs
    type: File
    doc: Contigs in FASTA format.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Activate debug mode.
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_extensions
    type:
      - 'null'
      - string
    doc: FASTA file extensions to search for in bin directories (used with 
      --bin_dirs).
    inputBinding:
      position: 101
      prefix: --fasta_extensions
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Enable low-memory mode for Diamond.
    inputBinding:
      position: 101
      prefix: --low_mem
  - id: max_contamination
    type:
      - 'null'
      - int
    doc: Maximum contamination allowed for intermediate bin creation and final 
      bin selection.
    inputBinding:
      position: 101
      prefix: --max_contamination
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length (bp) allowed for intermediate bin creation and final bin
      selection.
    inputBinding:
      position: 101
      prefix: --max_length
  - id: min_completeness
    type:
      - 'null'
      - int
    doc: Minimum completeness required for intermediate bin creation and final 
      bin selection.
    inputBinding:
      position: 101
      prefix: --min_completeness
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length (bp) required for intermediate bin creation and final 
      bin selection.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: no_debug
    type:
      - 'null'
      - boolean
    doc: Activate debug mode.
    inputBinding:
      position: 101
      prefix: --no-debug
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Show progress bar while fetching pangenomes (disable with 
      --no-progress).
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: no_resume
    type:
      - 'null'
      - boolean
    doc: 'Resume mode: reuse existing temporary files if possible.'
    inputBinding:
      position: 101
      prefix: --no-resume
  - id: no_write_fasta_bins
    type:
      - 'null'
      - boolean
    doc: Write final selected bins as FASTA files (disable with 
      --no-write-fasta-bins).
    inputBinding:
      position: 101
      prefix: --no-write-fasta-b
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to final bin names (e.g. '--prefix sample1' will produce 
      'sample1_bin1.fa', 'sample1_bin2.fa').
    inputBinding:
      position: 101
      prefix: --prefix
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress bar while fetching pangenomes (disable with 
      --no-progress).
    inputBinding:
      position: 101
      prefix: --progress
  - id: proteins
    type:
      - 'null'
      - File
    doc: FASTA file of predicted proteins in Prodigal format (>contigID_geneID).
      Skips the gene prediction step if provided.
    inputBinding:
      position: 101
      prefix: --proteins
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Enable quiet mode (only show warnings and errors).
    inputBinding:
      position: 101
      prefix: --quiet
  - id: resume
    type:
      - 'null'
      - boolean
    doc: 'Resume mode: reuse existing temporary files if possible.'
    inputBinding:
      position: 101
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode (show detailed debug information).
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_fasta_bins
    type:
      - 'null'
      - boolean
    doc: Write final selected bins as FASTA files (disable with 
      --no-write-fasta-bins).
    inputBinding:
      position: 101
      prefix: --write-fasta-bins
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binette:1.2.1--pyh7e72e81_0
