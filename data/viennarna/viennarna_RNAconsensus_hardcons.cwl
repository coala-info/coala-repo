cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAconsensus
  - hardcons
label: viennarna_RNAconsensus_hardcons
doc: |-
  Read a multiple sequence alignment and a consensus structure (RNAalifold output or dot plot) and write, for each sequence, name, sequence and a constraint structure suitable for piping into RNAfold -C (legacy refold.pl mode).

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: Multiple sequence alignment file.
    inputBinding:
      position: 1
      prefix: --alignment
  - id: output
    type:
      - 'null'
      - string
    doc: A file or directory where to store the output.
    inputBinding:
      position: 1
      prefix: --output
  - id: turn
    type:
      - 'null'
      - int
    doc: Minimum hairpin length.
    inputBinding:
      position: 1
      prefix: --turn
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run the predictions instead of producing output that can be used with RNAfold.
    inputBinding:
      position: 1
      prefix: --run
  - id: enforce
    type:
      - 'null'
      - boolean
    doc: Enforce the structure constraint for single sequence predictions.
    inputBinding:
      position: 1
      prefix: --enforce
  - id: alifold_output
    type:
      - 'null'
      - File
    doc: The output of RNAalifold for the input alignment (consensus MFE mode).
    inputBinding:
      position: 1
      prefix: --alifold-output
  - id: dotplot
    type:
      - 'null'
      - File
    doc: The dot plot created by RNAalifold for the input alignment (consensus probabilities mode).
    inputBinding:
      position: 1
      prefix: --dotplot
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Base pair probability threshold: only base pairs with higher probability are used.'
    inputBinding:
      position: 1
      prefix: --threshold
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: The multiple sequence alignment file name if not given with --alignment.
    inputBinding:
      position: 100
  - id: structure_file
    type:
      - 'null'
      - File
    doc: The RNAalifold output or dot plot file name.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAconsensus_hardcons.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
