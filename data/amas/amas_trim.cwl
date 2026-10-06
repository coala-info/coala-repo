cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - trim
label: amas_trim
doc: "Trim alignment by occupancy. Optionally removes sites that are not parsimony informative. CAUTION: when running on amino acids stop codons marked with * will be treated as missing data!\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: out_format
    type: ['null', {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}]
    doc: 'File format for the output alignment. Default: fasta'
    inputBinding:
      position: 1
      prefix: --out-format
  - id: trim_out
    type: ['null', string]
    doc: 'File name for the trimmed alignment when providing a single file as input.'
    inputBinding:
      position: 1
      prefix: --trim-out
  - id: trim_fraction
    type: ['null', float]
    doc: 'Columns in the alignments with occupancy lower than this value will be removed. Default: 0.6'
    inputBinding:
      position: 1
      prefix: --trim-fraction
  - id: retain_only_parsimony_sites
    type: ['null', boolean]
    doc: 'Only write parsimony informative columns in trimmed alignment Default: write all columns'
    inputBinding:
      position: 1
      prefix: --retain-only-parsimony-sites
  - id: check_align
    type: ['null', boolean]
    doc: 'Check if input sequences are aligned. Default: no check'
    inputBinding:
      position: 1
      prefix: --check-align
  - id: cores
    type: ['null', int]
    doc: 'Number of cores used. Default: 1'
    inputBinding:
      position: 1
      prefix: --cores
  - id: in_files
    type: File[]
    doc: 'Alignment files to be taken as input'
    inputBinding:
      position: 1
      prefix: --in-files
  - id: in_format
    type: {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}
    doc: 'The format of input alignment'
    inputBinding:
      position: 1
      prefix: --in-format
  - id: data_type
    type: {type: enum, symbols: [aa, dna]}
    doc: 'Type of data'
    inputBinding:
      position: 1
      prefix: --data-type
outputs:
  - id: trimmed_alignments
    type: File[]
    doc: Trimmed alignments (trimmed_<input name>, or the --trim-out name)
    outputBinding:
      glob: '$(inputs.trim_out ? inputs.trim_out : "trimmed_*")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
