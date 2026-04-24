cwlVersion: v1.2
class: CommandLineTool
baseCommand: corrprofile
label: dnp-corrprofile
doc: "This program computes correlations between the profiles of dinucleotide\n  \
  \  frequency on forward and reverse complent sequences within a sliding\n    window.\n\
  \nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs:
  - id: dinucleotide_profiles_file
    type: File
    doc: dinucleotideProfilesFile
    inputBinding:
      position: 1
  - id: length
    type:
      - 'null'
      - int
    doc: Dinucleotide profile sequence length. In range [25..600].
    inputBinding:
      position: 102
      prefix: --length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print parameters and variables.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: "Turn this option off to disable version update notifications of the\n  \
      \        application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    inputBinding:
      position: 102
      prefix: --version-check
  - id: window
    type:
      - 'null'
      - int
    doc: Sliding window size, < than length. In range [10..146].
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-corrprofile:1.0--hd6d6fdc_6
stdout: dnp-corrprofile.out
