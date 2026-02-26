cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_hexcalibrate
doc: "Options:\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: coding
    type:
      - 'null'
      - File
    doc: "Should point towards a Fasta-file of coding\ntranscripts (transcripts HAVE
      to be in-frame)."
    inputBinding:
      position: 101
      prefix: --coding
  - id: noncoding
    type:
      - 'null'
      - File
    doc: "Fasta-file with transcripts or sequences that are NOT\ncoding."
    inputBinding:
      position: 101
      prefix: --noncoding
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Name or path of the file to write. Will be a tab-\ndelimited text file (.tsv)."
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
