cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicore
label: epicore_generate-epicore-csv
doc: "Computes peptide groups and consensus epitopes from an immunopeptidomics evidence file.\n\nTool homepage: https://github.com/AG-Walz/epicore"
inputs:
  - id: reference_proteome
    type: File
    doc: Reference proteome FASTA file containing all protein accessions of the evidence file
    inputBinding:
      position: 1
      prefix: --reference_proteome
  - id: out_dir
    type: string
    doc: Output directory (created before the run)
    inputBinding:
      position: 2
      prefix: --out_dir
  - id: evidence_file
    type: File
    doc: Evidence file (csv, tsv or xlsx) from a search engine
    inputBinding:
      position: 10
      prefix: --evidence_file
  - id: html
    type:
      - 'null'
      - boolean
    doc: Write an HTML report
    inputBinding:
      position: 11
      prefix: --html
  - id: report
    type:
      - 'null'
      - boolean
    doc: Write a report
    inputBinding:
      position: 12
      prefix: --report
  - id: end_column
    type:
      - 'null'
      - string
    doc: Column header of the peptide end positions
    inputBinding:
      position: 13
      prefix: --end_column
  - id: start_column
    type:
      - 'null'
      - string
    doc: Column header of the peptide start positions
    inputBinding:
      position: 14
      prefix: --start_column
  - id: prot_accession
    type:
      - 'null'
      - string
    doc: Protein accession
    inputBinding:
      position: 15
      prefix: --prot_accession
  - id: mod_pattern
    type:
      - 'null'
      - string
    doc: Comma separated delimiters for peptide modifications
    inputBinding:
      position: 16
      prefix: --mod_pattern
  - id: delimiter
    type: string
    doc: Delimiter that separates multiple values in one cell of the evidence file
    inputBinding:
      position: 17
      prefix: --delimiter
  - id: intensity_column
    type:
      - 'null'
      - string
    doc: Column header of the peptide intensities
    inputBinding:
      position: 18
      prefix: --intensity_column
  - id: protacc_column
    type: string
    doc: Column header of the protein accessions
    inputBinding:
      position: 19
      prefix: --protacc_column
  - id: seq_column
    type: string
    doc: Column header of the peptide sequences
    inputBinding:
      position: 20
      prefix: --seq_column
  - id: max_step_size
    type: int
    doc: Two peptides with a start distance below this value are always put in one group
    inputBinding:
      position: 21
      prefix: --max_step_size
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimal overlap between two peptides of the same group
    inputBinding:
      position: 22
      prefix: --min_overlap
  - id: min_epi_length
    type:
      - 'null'
      - int
    doc: Minimal length of consensus epitopes
    inputBinding:
      position: 23
      prefix: --min_epi_length
arguments:
  - position: 5
    valueFrom: generate-epicore-csv
outputs:
  - id: out_dir_out
    type: Directory
    doc: Output directory with the results
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
stdout: epicore_generate-epicore-csv.out
