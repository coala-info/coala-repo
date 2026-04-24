cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch trypsinize
label: msstitch_trypsinize
doc: "Trypsinizes proteins in a file.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: cut_proline
    type:
      - 'null'
      - boolean
    doc: Flag to make trypsin before a proline residue. Then filtering will be 
      done against both cut and non-cut peptides.
    inputBinding:
      position: 101
      prefix: --cutproline
  - id: ignore_stop_codons
    type:
      - 'null'
      - boolean
    doc: Ignore stop codons in protein sequences when trypsinizing them (default
      is to split on them.
    inputBinding:
      position: 101
      prefix: --ignore-stop-codons
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of peptide to be included
    inputBinding:
      position: 101
      prefix: --minlen
  - id: miss_cleavage
    type:
      - 'null'
      - int
    doc: Amount of missed cleavages to allow when trypsinizing, default is 0
    inputBinding:
      position: 101
      prefix: --miscleav
  - id: nterm_meth_loss
    type:
      - 'null'
      - boolean
    doc: Include peptides in trypsinization where the protein N-term methionine 
      residue has been lost. When used in storeseq, the filter database should 
      be built with this flag in order for the filtering to work.
    inputBinding:
      position: 101
      prefix: --nterm-meth-loss
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
