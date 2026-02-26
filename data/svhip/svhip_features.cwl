cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_features
doc: "Calculate features for SVHIP.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: hexamer_model
    type:
      - 'null'
      - File
    doc: The Location of the statistical Hexamer model to use. An example file 
      is included with the download as Human_hexamer.tsv, which will be used as 
      a fallback.
    inputBinding:
      position: 101
      prefix: --hexamer-model
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Also scan the reverse complement when calculating features.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Set the --stdout flag to False if you do not want to have output 
      printed to screen as well. This feature is mostly for manual redirection 
      to files.
    default: true
    inputBinding:
      position: 101
      prefix: --stdout
  - id: tree_path
    type:
      - 'null'
      - File
    doc: If an evolutionary tree of species in the alignment is available in 
      Newick format, you can pass it here. Names have to be identical. If None 
      is passed, one will be estimated based on sequences at hand.
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Name for the output file. Optional here, as features can also be 
      printed to stdout.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
