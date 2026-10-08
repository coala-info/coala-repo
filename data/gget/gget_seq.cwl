cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - seq
label: gget_seq
doc: 'Fetch nucleotide or amino acid sequence (FASTA) of a gene (and all isoforms)
  or transcript by Ensembl, WormBase or FlyBase ID.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: ens_ids
    type:
      type: array
      items: string
    doc: One or more Ensembl, WormBase, or FlyBase IDs.
    inputBinding:
      position: 1
  - id: id_deprecated
    type:
      - 'null'
      - type: array
        items: string
    doc: DEPRECATED - use positional argument instead. One or more Ensembl, WormBase
      or FlyBase IDs.
    inputBinding:
      position: 102
      prefix: --ens_ids
  - id: isoforms
    type:
      - 'null'
      - boolean
    doc: 'Returns sequences of all known transcripts (default: False). (Only for gene
      IDs.)'
    inputBinding:
      position: 102
      prefix: --isoforms
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seqtype
    type:
      - 'null'
      - string
    doc: DEPRECATED - use True/False flag 'translate' instead.
    inputBinding:
      position: 102
      prefix: --seqtype
  - id: transcribe
    type:
      - 'null'
      - boolean
    doc: DEPRECATED - use True/False flag 'translate' instead.
    inputBinding:
      position: 102
      prefix: --transcribe
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Returns amino acid sequences from UniProt. (Otherwise returns nucleotide
      sequences from Ensembl.)
    inputBinding:
      position: 102
      prefix: --translate
  - id: out_path
    type: string
    default: results.fa
    doc: Path to the FASTA file the results will be saved in, e.g. path/to/directory/results.fa.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: FASTA file with the sequences.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
