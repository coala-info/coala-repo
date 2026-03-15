cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - view
label: diamond_view
doc: View and convert DIAMOND alignment archive (DAA) files
inputs:
  - id: daa
    type: File
    doc: DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 101
      prefix: --daa
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: out
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: top
    type:
      - 'null'
      - float
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    inputBinding:
      position: 101
      prefix: --top
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format (0=BLAST pairwise, 5=BLAST XML, 6=BLAST tabular, 100=DAA,
      101=SAM, 102=Taxonomic classification, 103=PAF, 104=JSON). Values 6 and 
      104 may be followed by a space-separated list of keywords.
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: qnum_offset
    type:
      - 'null'
      - int
    doc: offset added to query ordinal id (qnum field)
    inputBinding:
      position: 101
      prefix: --qnum-offset
  - id: snum_offset
    type:
      - 'null'
      - int
    doc: offset added to subject ordinal id (snum field)
    inputBinding:
      position: 101
      prefix: --snum-offset
  - id: forwardonly
    type:
      - 'null'
      - boolean
    doc: only show alignments of forward strand
    inputBinding:
      position: 101
      prefix: --forwardonly
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
