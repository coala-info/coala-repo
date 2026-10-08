cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - elm
label: gget_elm
doc: 'Locally predicts Eukaryotic Linear Motifs from an amino acid sequence or UniProt
  Acc using data from the ELM database (http://elm.eu.org/media/Elm_academic_license.pdf).


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: sequence
    type: string
    doc: Amino acid sequence or Uniprot Acc. If Uniprot Acc, use flag '--uniprot'.
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Returns results in csv format instead of json.
    inputBinding:
      position: 102
      prefix: --csv
  - id: diamond_binary
    type:
      - 'null'
      - string
    doc: 'Path to DIAMOND binary. Default: None -> Uses DIAMOND binary installed with
      gget.'
    inputBinding:
      position: 102
      prefix: --diamond_binary
  - id: expand
    type:
      - 'null'
      - boolean
    doc: Expand the information returned in the regex data frame to include the protein
      names, organisms, and references that the motif was orignally validated on.
    inputBinding:
      position: 102
      prefix: --expand
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: 'Sensitivity of DIAMOND alignment. One of fast, mid-sensitive, sensitive,
      more-sensitive, very-sensitive, ultra-sensitive. (default: very-sensitive)'
    inputBinding:
      position: 102
      prefix: --sensitivity
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used in DIAMOND alignment. (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: uniprot
    type:
      - 'null'
      - boolean
    doc: Use this flag if input is a Uniprot Acc instead of an amino acid sequence.
    inputBinding:
      position: 102
      prefix: --uniprot
  - id: out_path
    type: string
    default: elm_results
    doc: Path to folder to save results in, e.g. path/to/directory.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Folder with the ELM results (ortholog and regex tables).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
