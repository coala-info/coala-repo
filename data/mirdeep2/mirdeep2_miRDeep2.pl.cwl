cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miRDeep2.pl
label: mirdeep2_miRDeep2.pl
doc: "Run the miRDeep2 pipeline: identify known and novel miRNAs from deep sequencing reads mapped to a genome\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: reads
    type: File
    doc: Deep sequences in fasta format; identifiers need a prefix, a running number and _x<count>; no redundant sequences
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: Genome contigs in fasta format with unique identifiers
    inputBinding:
      position: 2
  - id: mappings
    type: File
    doc: Reads mapped against the genome in arf format
    inputBinding:
      position: 3
  - id: mirnas_ref
    type: File
    doc: miRBase mature miRNA sequences of the species analyzed, fasta
    inputBinding:
      position: 4
  - id: mirnas_other
    type: File
    doc: miRBase mature miRNA sequences of 1-5 closely related species, fasta
    inputBinding:
      position: 5
  - id: precursors
    type: File
    doc: miRBase precursor sequences of the species analyzed, fasta
    inputBinding:
      position: 6
  - id: min_stack_height
    type:
      - 'null'
      - int
    doc: Minimum read stack height that triggers analysis; disables automatic estimation of the optimal value
    inputBinding:
      position: 107
      prefix: -a
  - id: max_precursors
    type:
      - 'null'
      - int
    doc: Maximum number of precursors to analyze when automatic excision gearing is used, default 50000; -1 analyzes all
    inputBinding:
      position: 107
      prefix: -g
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum score cut-off for predicted novel miRNAs to be displayed in the overview table, default 0
    inputBinding:
      position: 107
      prefix: -b
  - id: disable_randfold
    type:
      - 'null'
      - boolean
    doc: Disable randfold analysis
    inputBinding:
      position: 107
      prefix: -c
  - id: disable_pdf
    type:
      - 'null'
      - boolean
    doc: Disable pdf generation
    inputBinding:
      position: 107
      prefix: -d
  - id: species
    type:
      - 'null'
      - string
    doc: Species being analyzed, used to link to the UCSC browser entry
    inputBinding:
      position: 107
      prefix: -t
  - id: list_ucsc_species
    type:
      - 'null'
      - boolean
    doc: Output list of UCSC browser species that are supported and exit
    inputBinding:
      position: 107
      prefix: -u
  - id: remove_tmp_dir
    type:
      - 'null'
      - boolean
    doc: Remove directory with temporary files
    inputBinding:
      position: 107
      prefix: -v
  - id: no_sort_by_sample
    type:
      - 'null'
      - boolean
    doc: Do not sort aligned reads in pdf files by sample (multiple samples only)
    inputBinding:
      position: 107
      prefix: -o
  - id: star_sequences
    type:
      - 'null'
      - File
    doc: File with known miRBase star sequences
    inputBinding:
      position: 107
      prefix: -s
  - id: time_stamp_tag
    type:
      - 'null'
      - string
    doc: Additional tag appended to current time stamp
    inputBinding:
      position: 107
      prefix: -z
  - id: mirbase_v18_ids
    type:
      - 'null'
      - boolean
    doc: Use if mature_ref_miRNAs contain miRBase v18 identifiers (5p and 3p) instead of previous ids from v17
    inputBinding:
      position: 107
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (progress log)
  - id: result_html
    type:
      - 'null'
      - type: array
        items: File
    doc: Overview table of novel and known miRNAs, hyperlinked to pdfs
    outputBinding:
      glob: 'result_*.html'
  - id: result_csv
    type:
      - 'null'
      - type: array
        items: File
    doc: Spread-sheet format of the results table
    outputBinding:
      glob: 'result_*.csv'
  - id: result_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: Results in bed format
    outputBinding:
      glob: 'result_*.bed'
  - id: expression_html
    type:
      - 'null'
      - type: array
        items: File
    doc: Expression of known miRNAs as html
    outputBinding:
      glob: 'expression_*.html'
  - id: expression_csv
    type:
      - 'null'
      - type: array
        items: File
    doc: Read counts of known miRNAs
    outputBinding:
      glob: 'miRNAs_expressed_all_samples_*.csv'
  - id: mrd_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Text output of the reported hairpins (output.mrd)
    outputBinding:
      glob: 'mirna_results_*'
  - id: pdf_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Read signature and structure pdfs
    outputBinding:
      glob: 'pdfs_*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: miRDeep2.out
stderr: miRDeep2.err
