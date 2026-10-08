cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - alnfilt
label: enhjoerning_unicorn_alnfilt
doc: "Filter alignments based on user-defined criteria.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: bam
    type: File
    doc: "Input BAM or SAM file"
    inputBinding:
      position: 101
      prefix: -b
  - id: outbam
    type:
      - 'null'
      - string
    doc: "Output BAM file [stdout]"
    inputBinding:
      position: 101
      prefix: -o
  - id: mode
    type:
      - 'null'
      - string
    doc: "Filter mode [alltop]. Available modes: RNDTOP (randomly select a best alignment), ALLTOP (select all best alignments), PCTTOP (select alignments within --pct percentage of best alignment), ALL (select all alignments)."
    inputBinding:
      position: 101
      prefix: --mode
  - id: pct
    type:
      - 'null'
      - float
    doc: "Percentage threshold for PCTTOP mode [0.90]"
    inputBinding:
      position: 101
      prefix: --pct
  - id: minani
    type:
      - 'null'
      - float
    doc: "Minimum average nucleotide identity [90.0]"
    inputBinding:
      position: 101
      prefix: --minani
  - id: maxani
    type:
      - 'null'
      - float
    doc: "Maximum average nucleotide identity [100.0]. The program starts with 0 when this option is not given, which removes every alignment, so the default is set to 100.0 here."
    default: 100.0
    inputBinding:
      position: 101
      prefix: --maxani
  - id: strictbounds
    type:
      - 'null'
      - boolean
    doc: "Remove query if ANI out of bounds at any alignment."
    inputBinding:
      position: 101
      prefix: --strictbounds
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print libunicorn's messages."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: "BAM written to the standard output when --outbam is not given"
  - id: out_bam
    type:
      - 'null'
      - File
    doc: "Output BAM file"
    outputBinding:
      glob: $(inputs.outbam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn_alnfilt.out
