cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - view
label: diamond_view
doc: "View and convert DIAMOND alignment archives (DAA)\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: daa
    type:
      - 'null'
      - File
    doc: DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 101
      prefix: --daa
  - id: forwardonly
    type:
      - 'null'
      - boolean
    doc: only show alignments of forward strand
    inputBinding:
      position: 101
      prefix: --forwardonly
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    default: 25
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: outfmt
    type:
      - 'null'
      - string
    doc: output format (0=BLAST pairwise, 5=BLAST XML, 6=BLAST tabular, 100=DAA,
      101=SAM, 102=Taxonomic classification, 103=PAF, 104=JSON). Values 6 and 
      104 may be followed by a space-separated list of keywords.
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - float
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    inputBinding:
      position: 101
      prefix: --top
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
