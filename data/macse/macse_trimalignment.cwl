cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_trimalignment
doc: "MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and
  stop codons.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: alignSequences
    type:
      - 'null'
      - boolean
    doc: aligns nucleotide (NT) coding sequences using their amino acid (AA) 
      translations
    inputBinding:
      position: 101
  - id: alignTwoProfiles
    type:
      - 'null'
      - boolean
    doc: aligns two previously computed nucleotide alignments (also called 
      profiles) without questioning them
    inputBinding:
      position: 101
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode.
    inputBinding:
      position: 101
      prefix: -debug
  - id: enrichAlignment
    type:
      - 'null'
      - boolean
    doc: adds sequences to a pre-existing nucleotide alignment
    inputBinding:
      position: 101
  - id: exportAlignment
    type:
      - 'null'
      - boolean
    doc: allows to export a MACSE alignment and to compute some statistics, it 
      can...
    inputBinding:
      position: 101
  - id: mergeTwoMasks
    type:
      - 'null'
      - boolean
    doc: indicates nucleotides kept after applying mask1 filtering then mask2 
      filtering (useful for traceability)....
    inputBinding:
      position: 101
  - id: multiPrograms
    type:
      - 'null'
      - boolean
    doc: sequentially executes multiple MACSE commands contained in a text file 
      (one per line)....
    inputBinding:
      position: 101
  - id: program_name
    type:
      - 'null'
      - string
    doc: Specifies the MACSE program to run.
    inputBinding:
      position: 101
      prefix: -prog
  - id: refineAlignment
    type:
      - 'null'
      - boolean
    doc: improves the input nucleotide alignment
    inputBinding:
      position: 101
  - id: reportGapsAA2NT
    type:
      - 'null'
      - boolean
    doc: uses a amino acid alignment to align nucleotide sequences....
    inputBinding:
      position: 101
  - id: reportMaskAA2NT
    type:
      - 'null'
      - boolean
    doc: uses a filtered amino acid alignment to filter a nucleotide 
      alignment....
    inputBinding:
      position: 101
  - id: splitAlignment
    type:
      - 'null'
      - boolean
    doc: splits one alignment, to extract a subset of sequences and/or sites....
    inputBinding:
      position: 101
  - id: translateNT2AA
    type:
      - 'null'
      - boolean
    doc: translates nucleotides into amino acids
    inputBinding:
      position: 101
  - id: trimAlignment
    type:
      - 'null'
      - boolean
    doc: trims the input alignment by removing gappy sites at the beginning/end 
      of the alignment....
    inputBinding:
      position: 101
  - id: trimNonHomologousFragments
    type:
      - 'null'
      - boolean
    doc: identifies (and trims) sequence fragments that do not share homology 
      with other sequences and remove those fragments....
    inputBinding:
      position: 101
  - id: trimSequences
    type:
      - 'null'
      - boolean
    doc: removes the 3' and 5' parts of the input sequence that are non 
      homologous to an alignment....
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
stdout: macse_trimalignment.out
