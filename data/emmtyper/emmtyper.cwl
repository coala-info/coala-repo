cwlVersion: v1.2
class: CommandLineTool
baseCommand: emmtyper
label: emmtyper
doc: "Welcome to emmtyper.\n\nTool homepage: https://github.com/MDUPHL/emmtyper"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: align_diff
    type:
      - 'null'
      - int
    doc: '[BLAST] Threshold for difference between alignment length and subject length
      in BLAST hit.'
    inputBinding:
      position: 102
      prefix: --align-diff
  - id: blast_db
    type:
      - 'null'
      - File
    doc: Path to EMM BLAST DB (FASTA file with its BLAST index files)
    inputBinding:
      position: 102
      prefix: --blast_db
    secondaryFiles:
      - pattern: .nhr
        required: false
      - pattern: .nin
        required: false
      - pattern: .nsq
        required: false
  - id: blast_path
    type:
      - 'null'
      - string
    doc: '[BLAST] Specify full path to blastn executable.'
    inputBinding:
      position: 102
      prefix: --blast-path
  - id: cluster_distance
    type:
      - 'null'
      - int
    doc: Distance between cluster of matches to consider as different clusters.
    inputBinding:
      position: 102
      prefix: --cluster-distance
  - id: culling_limit
    type:
      - 'null'
      - int
    doc: '[BLAST] Total hits to return in a position.'
    inputBinding:
      position: 102
      prefix: --culling-limit
  - id: dust
    type:
      - 'null'
      - string
    doc: '[BLAST] Filter query sequence with DUST.'
    inputBinding:
      position: 102
      prefix: --dust
  - id: gap
    type:
      - 'null'
      - int
    doc: '[BLAST] Threshold gap to allow in BLAST hit.'
    inputBinding:
      position: 102
      prefix: --gap
  - id: ispcr_path
    type:
      - 'null'
      - string
    doc: '[isPcr] Specify full path to isPcr executable.'
    inputBinding:
      position: 102
      prefix: --ispcr-path
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep BLAST and isPcr output files.
    inputBinding:
      position: 102
      prefix: --keep
  - id: max_size
    type:
      - 'null'
      - int
    doc: '[isPcr] Maximum size of PCR product.'
    inputBinding:
      position: 102
      prefix: --max-size
  - id: min_good
    type:
      - 'null'
      - int
    doc: '[isPcr] Minimum size where there must be 2 matches for each mismatch.'
    inputBinding:
      position: 102
      prefix: --min-good
  - id: min_perfect
    type:
      - 'null'
      - int
    doc: "[isPcr] Minimum size of perfect match at 3' primer end."
    inputBinding:
      position: 102
      prefix: --min-perfect
  - id: mismatch
    type:
      - 'null'
      - int
    doc: '[BLAST] Threshold for number of mismatch to allow in BLAST hit.'
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output stream. Path to file for output to a file. [default: stdout]'
    inputBinding:
      position: 102
      prefix: --output
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format.
    inputBinding:
      position: 102
      prefix: --output-format
  - id: percent_identity
    type:
      - 'null'
      - int
    doc: '[BLAST] Minimal percent identity of sequence.'
    inputBinding:
      position: 102
      prefix: --percent-identity
  - id: primer_db
    type:
      - 'null'
      - File
    doc: '[isPcr] PCR primer. Text file with 3 columns: Name, Forward Primer, Reverse
      Primer.'
    inputBinding:
      position: 102
      prefix: --primer-db
  - id: workflow
    type:
      - 'null'
      - string
    doc: Choose workflow
    inputBinding:
      position: 102
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result file written with --output
    outputBinding:
      glob: $(inputs.output)
  - id: kept_files
    type:
      type: array
      items: File
    doc: BLAST and isPcr output files kept with --keep
    outputBinding:
      glob:
        - '*.tmp'
        - '*.blast*'
        - '*.isPcr*'
        - '*.pcr*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emmtyper:0.2.0--py_0
stdout: emmtyper.out
