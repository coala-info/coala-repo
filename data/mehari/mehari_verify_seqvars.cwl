cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - verify
  - seqvars
label: mehari_verify_seqvars
doc: "Compare variant effect predictions to VEP ones\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: path_db
    type: Directory
    doc: "Path to the mehari database folder"
    inputBinding:
      position: 1
      prefix: --path-db
  - id: path_input_tsv
    type: File
    doc: "Path to the input TSV file"
    inputBinding:
      position: 2
      prefix: --path-input-tsv
  - id: path_reference_fasta
    type: File
    doc: "Path to the reference FASTA file"
    inputBinding:
      position: 3
      prefix: --path-reference-fasta
  - id: path_output_tsv
    type: string
    doc: "Path to output TSV file"
    inputBinding:
      position: 4
      prefix: --path-output-tsv
  - id: in_memory_reference
    type:
      - 'null'
      - boolean
    doc: "Read the reference genome into memory"
    inputBinding:
      position: 5
      prefix: --in-memory-reference
  - id: report_most_severe_consequence_by
    type:
      - 'null'
      - string
    doc: "Whether to report only the worst consequence for each picked transcript: gene, transcript, or allele"
    inputBinding:
      position: 6
      prefix: --report-most-severe-consequence-by
  - id: pick_transcript
    type:
      - 'null'
      - string
    doc: "Which kind of transcript to pick / restrict to (mane-select, mane-select-backport, mane-plus-clinical, mane-plus-clinical-backport, length, ensembl-canonical, ensembl-canonical-backport, ref-seq-select, ref-seq-select-backport, gencode-primary, gencode-primary-backport, basic, basic-backport). Default is not to pick at all"
    inputBinding:
      position: 7
      prefix: --pick-transcript
  - id: pick_transcript_mode
    type:
      - 'null'
      - string
    doc: "How to handle multiple transcripts: first or all (default: all)"
    inputBinding:
      position: 8
      prefix: --pick-transcript-mode
  - id: max_var_count
    type:
      - 'null'
      - int
    doc: "For debug purposes, maximal number of variants to annotate"
    inputBinding:
      position: 9
      prefix: --max-var-count
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 10
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 11
      prefix: --quiet
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: "Verification result TSV file"
    outputBinding:
      glob: $(inputs.path_output_tsv)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_verify_seqvars.out
