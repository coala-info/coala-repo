cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - muscle
label: gget_muscle
doc: 'Align multiple nucleotide or amino acid sequences against each other (using
  the Muscle v5 algorithm).


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: fasta
    type:
      type: array
      items:
        - string
        - File
    doc: List of sequences or path to fasta file containing the sequences to be aligned.
    inputBinding:
      position: 1
  - id: fasta_deprecated
    type:
      - 'null'
      - File
    doc: DEPRECATED - use positional argument instead. Path to fasta file containing
      the sequences to be aligned.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: super5
    type:
      - 'null'
      - boolean
    doc: If True, align input using Super5 algorithm instead of PPP algorithm to decrease
      time and memory. Use for large inputs (a few hundred sequences).
    inputBinding:
      position: 102
      prefix: --super5
  - id: out_path
    type: string
    default: results.afa
    doc: Path to save an 'aligned FASTA' (.afa) file with the results, e.g. path/to/directory/results.afa.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Aligned FASTA file.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
