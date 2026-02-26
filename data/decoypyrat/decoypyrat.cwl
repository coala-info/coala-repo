cwlVersion: v1.2
class: CommandLineTool
baseCommand: decoypyrat
label: decoypyrat
doc: "Create decoy protein sequences. Each protein is reversed and the cleavage\n\
  sites switched with preceding amino acid. Peptides are checked for existence\nin
  target sequences if found the tool will attempt to shuffle them.\n\nTool homepage:
  https://github.com/tdido/DecoyPYrat"
inputs:
  - id: input_fasta
    type: File
    doc: "FASTA file of target proteins sequences for which to\n                 \
      \       create decoys"
    inputBinding:
      position: 1
  - id: anti_cleavage_sites
    type:
      - 'null'
      - string
    doc: "A list of amino acids at which not to cleave if\n                      \
      \  following cleavage site ie. Proline. Default = none"
    default: none
    inputBinding:
      position: 102
      prefix: --anti_cleavage_sites
  - id: cleavage_position
    type:
      - 'null'
      - string
    doc: "Set cleavage to be c or n terminal of specified\n                      \
      \  cleavage sites. Default = c"
    default: c
    inputBinding:
      position: 102
      prefix: --cleavage_position
  - id: cleavage_sites
    type:
      - 'null'
      - string
    doc: "A list of amino acids at which to cleave during\n                      \
      \  digestion. Default = KR"
    default: KR
    inputBinding:
      position: 102
      prefix: --cleavage_sites
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: "Set accesion prefix for decoy proteins in output.\n                    \
      \    Default=XXX"
    default: XXX
    inputBinding:
      position: 102
      prefix: --decoy_prefix
  - id: do_not_shuffle
    type:
      - 'null'
      - boolean
    doc: "Turn OFF shuffling of decoy peptides that are in the\n                 \
      \       target database. Default=false"
    default: false
    inputBinding:
      position: 102
      prefix: --do_not_shuffle
  - id: do_not_switch
    type:
      - 'null'
      - boolean
    doc: "Turn OFF switching of cleavage site with preceding\n                   \
      \     amino acid. Default=false"
    default: false
    inputBinding:
      position: 102
      prefix: --do_not_switch
  - id: keep_names
    type:
      - 'null'
      - boolean
    doc: Keep sequence names in the decoy output. Default=false
    default: false
    inputBinding:
      position: 102
      prefix: --keep_names
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: "Set maximum number of times to shuffle a peptide to\n                  \
      \      make it non-target before failing. Default=100"
    default: 100
    inputBinding:
      position: 102
      prefix: --max_iterations
  - id: memory_save
    type:
      - 'null'
      - boolean
    doc: "Slower but uses less memory (does not store decoy\n                    \
      \    peptide list). Default=false"
    default: false
    inputBinding:
      position: 102
      prefix: --memory_save
  - id: min_peptide_length
    type:
      - 'null'
      - int
    doc: "Set minimum length of peptides to compare between\n                    \
      \    target and decoy. Default = 5"
    default: 5
    inputBinding:
      position: 102
      prefix: --min_peptide_length
  - id: no_isobaric
    type:
      - 'null'
      - boolean
    doc: Do not make decoy peptides isobaric. Default=false
    default: false
    inputBinding:
      position: 102
      prefix: --no_isobaric
  - id: temp_file
    type:
      - 'null'
      - File
    doc: "Set temporary file to write decoys prior to shuffling.\n               \
      \         Default=tmp.fa"
    default: tmp.fa
    inputBinding:
      position: 102
      prefix: --temp_file
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Set file to write decoy proteins to. Default=decoy.fa
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decoypyrat:1.0.1--py_0
