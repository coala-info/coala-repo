cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ragtag.py
  - asmstats
label: ragtag_asmstats
doc: "Calculate assembly sequence stats (FASTA, FAI, sizes, GFA or AGP input); the\
  \ table is written to standard output.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs:
  - id: assembly_files
    type:
      type: array
      items: File
    doc: assembly files (bgzipped or uncompressed for FASTA); staged writable because
      the tool writes a .fai index beside a FASTA
    inputBinding:
      position: 2
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: genome_size
    type:
      - 'null'
      - int
    doc: genome size for NGx [null]
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.assembly_files)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_asmstats.out
