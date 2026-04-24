cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairalign
label: phylommand_pairalign
doc: "Perform pairwise alignment of DNA sequences given in fasta format.\n\nTool homepage:
  https://github.com/mr-y/phylommand"
inputs:
  - id: input_file
    type: File
    doc: Input DNA sequences in fasta format
    inputBinding:
      position: 1
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: input file is already aligned.
    inputBinding:
      position: 102
      prefix: --aligned
  - id: alignments
    type:
      - 'null'
      - boolean
    doc: output aligned sequences pairwise.
    inputBinding:
      position: 102
      prefix: --alignments
  - id: difference
    type:
      - 'null'
      - boolean
    doc: output difference between the Jukes-Cantor (JC) distance and proportion different
      sites.
    inputBinding:
      position: 102
      prefix: --difference
  - id: distances
    type:
      - 'null'
      - boolean
    doc: output proportion different sites, JC distance, and diference between the
      two.
    inputBinding:
      position: 102
      prefix: --distances
  - id: format
    type:
      - 'null'
      - string
    doc: set the format of the input to fasta or fasta with sequences pairwise (as
      output given the -a -n option). If sequences are aligned give the -A switch.
    inputBinding:
      position: 102
      prefix: --format
  - id: group
    type:
      - 'null'
      - string
    doc: cluster sequences that are similar and/or find the most inclusive taxa in
      a hierarchy that are alignable according to MAD. Accepts 'alignment_groups',
      'cluster', or 'both', with optional cut-off and taxonomy file.
    inputBinding:
      position: 102
      prefix: --group
  - id: jc_distance
    type:
      - 'null'
      - boolean
    doc: output Jukes-Cantor (JC) distance.
    inputBinding:
      position: 102
      prefix: --jc_distance
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: output in the form of a space separated left-upper triangular matrix.
    inputBinding:
      position: 102
      prefix: --matrix
  - id: names
    type:
      - 'null'
      - boolean
    doc: output sequence names (if outputting alignments then in fasta format).
    inputBinding:
      position: 102
      prefix: --names
  - id: proportion_difference
    type:
      - 'null'
      - boolean
    doc: output proportion sites that are different.
    inputBinding:
      position: 102
      prefix: --proportion_difference
  - id: similarity
    type:
      - 'null'
      - boolean
    doc: output similarity between sequences (1-proportion different).
    inputBinding:
      position: 102
      prefix: --similarity
  - id: threads
    type:
      - 'null'
      - int
    doc: set the number of threads additional to the controlling thread.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: get additional output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylommand:1.1.0--hc5cd53e_2
stdout: phylommand_pairalign.out
