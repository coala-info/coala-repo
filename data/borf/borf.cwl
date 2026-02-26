cwlVersion: v1.2
class: CommandLineTool
baseCommand: borf
label: borf
doc: "Get orf predicitions from a nucleotide fasta file\n\nTool homepage: https://github.com/betsig/borf"
inputs:
  - id: fasta_file
    type: File
    doc: fasta file to predict ORFs
    inputBinding:
      position: 1
  - id: all_orfs
    type:
      - 'null'
      - boolean
    doc: Return all ORFs for each sequence longer than the cutoff
    inputBinding:
      position: 102
      prefix: --all_orfs
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of fasta records to read in in each batch
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwriting of output files?
    inputBinding:
      position: 102
      prefix: --force_overwrite
  - id: orf_length
    type:
      - 'null'
      - int
    doc: Minimum ORF length (AA).
    default: 100
    inputBinding:
      position: 102
      prefix: --orf_length
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Predict orfs for both strands
    inputBinding:
      position: 102
      prefix: --strand
  - id: upstream_incomplete_length
    type:
      - 'null'
      - int
    doc: Minimum length (AA) of uninterupted sequence upstream of ORF to be 
      included for incomplete_5prime transcripts
    default: 50
    inputBinding:
      position: 102
      prefix: --upstream_incomplete_length
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: path to write output files. [OUTPUT_PATH].pep and [OUTPUT_PATH].txt
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/borf:1.2--py_0
