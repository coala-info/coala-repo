cwlVersion: v1.2
class: CommandLineTool
baseCommand: python dreamtools
label: dreamtools
doc: "General Description:\n    You must provide the challenge alias (e.g., D8C1 for
  DREAM8, Challenge 1)\n    and if there were several sub-challenges, you also must
  provide the\n    sub-challenge alias (e.g., sc1). Finally, the submission has to
  be\n    provided. The format must be in agreement with the description of the\n\
  \    challenge itself.\n\n    Help and documentation about the templates may be
  found either within\n    the online documentation http://pythonhosted.org/dreamtools/
  or within\n    the source code hosted on github http://github.com/dreamtools/dreamtools.\n\
  \n    Registered challenge so far (and sub-challenges) are:\nD2C1, D2C2, D2C3, D2C4,
  D2C5, D3C1, D3C2, D3C3, D3C4, D4C1, D4C2, D4C3, D5C1,\nD5C2, D5C3, D5C4, D6C2, D6C3,
  D6C4, D7C1, D7C3, D7C4, D8C1, D8C2, D8C3,\nD8dot5C1, D9C1, D9C3, D9dot5C1\n\nTool
  homepage: https://github.com/dreamtools/dreamtools"
inputs:
  - id: challenge
    type: string
    doc: "alias of the challenge (e.g., D8C1 stands fordream8\n                  \
      \      challenge 1)."
    inputBinding:
      position: 101
      prefix: --challenge
  - id: download_gold_standard
    type:
      - 'null'
      - boolean
    doc: "Download a gold standard, which can be used as a\n                     \
      \   submissions as well. It returns the location of the\n                  \
      \      file."
    inputBinding:
      position: 101
      prefix: --download-gold-standard
  - id: download_template
    type:
      - 'null'
      - boolean
    doc: "Download template. Templates for challenge may be\n                    \
      \    downloaded using this option. It returns the path to\n                \
      \        template."
    inputBinding:
      position: 101
      prefix: --download-template
  - id: filename
    type:
      - 'null'
      - type: array
        items: File
    doc: submission/filename to score.
    inputBinding:
      position: 101
      prefix: --filename
  - id: gold_standard
    type:
      - 'null'
      - File
    doc: "a gold standard filename. This may be required in some\n               \
      \         challenges e.g. D2C3"
    inputBinding:
      position: 101
      prefix: --gold-standard
  - id: info
    type:
      - 'null'
      - boolean
    doc: Prints general information about the challenge
    inputBinding:
      position: 101
      prefix: --info
  - id: onweb
    type:
      - 'null'
      - boolean
    doc: Open synapse project page in a browser
    inputBinding:
      position: 101
      prefix: --onweb
  - id: sub_challenge
    type:
      - 'null'
      - string
    doc: Name of the data files
    inputBinding:
      position: 101
      prefix: --sub-challenge
  - id: submission
    type:
      type: array
      items: File
    doc: submission/filename to score.
    inputBinding:
      position: 101
      prefix: --submission
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose option.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dreamtools:1.3.0--py36_0
stdout: dreamtools.out
