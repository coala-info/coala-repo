cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfa2tofasta.py
label: mtglink_gfa2tofasta.py
doc: "Convert a GFA file (GFA 2.0) to a FASTA file (gaps are returned as 'N's regions).\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: gfa
    type: File
    doc: "GFA 2.0 file (format: xxx.gfa)"
    inputBinding:
      prefix: "-in"
      valueFrom: $(self.basename)
  - id: out_fasta
    type: string
    doc: "Name of the output FASTA file"
    inputBinding:
      prefix: "-out"
  - id: flanking_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files named in the UR tags of the GFA, staged beside it
  - id: mtglink_results
    type: ['null', Directory]
    doc: MTG-Link results directory (staged as MTG-Link_results) holding the assembled sequences FASTA named in the GFA
outputs:
  - id: fasta
    type: File
    doc: FASTA file with the assembled sequences
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gfa)
      - $(inputs.flanking_fastas)
      - entryname: MTG-Link_results
        entry: $(inputs.mtglink_results)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
