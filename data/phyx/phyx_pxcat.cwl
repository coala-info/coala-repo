cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxcat
label: phyx_pxcat
doc: "Sequence file concatenation. This will take fasta, fastq, phylip, and nexus
  sequence formats. Individual files may be of different formats.\n\nTool homepage:
  https://github.com/FePhyFoFum/phyx"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence files
    inputBinding:
      position: 1
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 102
      prefix: --citation
  - id: flist
    type:
      - 'null'
      - File
    doc: file listing input files (one per line)
    inputBinding:
      position: 102
      prefix: --flist
  - id: seqf
    type:
      - 'null'
      - type: array
        items: File
    doc: list of input sequence files (space delimited)
    inputBinding:
      position: 102
      prefix: --seqf
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: export characters in uppercase
    inputBinding:
      position: 102
      prefix: --uppercase
outputs:
  - id: outf
    type:
      - 'null'
      - File
    doc: output sequence file, STOUT otherwise
    outputBinding:
      glob: $(inputs.outf)
  - id: partf
    type:
      - 'null'
      - File
    doc: output partition file, none otherwise
    outputBinding:
      glob: $(inputs.partf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
