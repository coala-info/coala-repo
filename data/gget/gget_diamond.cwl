cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - diamond
label: gget_diamond
doc: 'Align multiple protein or translated DNA sequences using DIAMOND.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: query
    type:
      type: array
      items:
        - string
        - File
    doc: Sequences (str or list) or path to FASTA file containing sequences to be
      aligned against the reference.
    inputBinding:
      position: 1
  - id: reference
    type:
      type: array
      items:
        - string
        - File
    doc: Reference sequences (str or list) or path to FASTA file containing reference
      sequences.
    inputBinding:
      position: 101
      prefix: --reference
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
    doc: 'Path to DIAMOND binary, e.g. path/bins/Linux/diamond. Default: None -> Uses
      DIAMOND binary installed with gget.'
    inputBinding:
      position: 102
      prefix: --diamond_binary
  - id: diamond_db
    type:
      - 'null'
      - string
    doc: 'Path to save DIAMOND database created from reference. Default: None -> Temporary
      db file will be deleted after alignment or saved in ''out'' if ''out'' is provided.'
    inputBinding:
      position: 102
      prefix: --diamond_db
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
      more-sensitive, very-sensitive or ultra-sensitive. (default: very-sensitive)'
    inputBinding:
      position: 102
      prefix: --sensitivity
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for alignment. (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: out_path
    type: string
    default: diamond_results
    doc: Path to folder to save DIAMOND results in, e.g. path/to/directory/results.json.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Folder with the alignment results (JSON, or CSV with --csv).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
