cwlVersion: v1.2
class: CommandLineTool
baseCommand: snap
label: snap
doc: "The general form of the snap command line is:\nsnap <HMM file> <FASTA file>
  [options]\nHMM file:\nThe most convenient way to specify the HMM file is by name.
  This requires\nthat the ZOE environment variable is set. In this case, snap will
  look\nfor the HMM file in $ZOE/HMM. You may also specify the HMM file by an\nexplicit
  path. The following are equivalent if $ZOE is in /usr/local:\n    snap C.elegans.hmm
  ...\n    snap /usr/local/Zoe/HMM/C.elegans.hmm ...\n    snap worm ...  # there are
  a few convenient aliases in $ZOE/HMM\nFASTA file:\nIf you have several sequences
  to analyze, it is more efficient to run\nsnap on a concatenated FASTA file rather
  than separate runs on single\nsequence files. The seqeuence may be in a compressed
  format\nIf sequences have been masked with lowercase letters, use -lcmask to\nprevent
  exons from appearing in masked DNA.\nOutput:\nAnnotation is reported to stdout in
  a non-standard format (ZFF). You can\nchange to GFF or ACEDB with the -gff or -ace
  options. Proteins and\ntranscripts are reported to FASTA files with the -aa and
  -tx options.\nExternal definitions:\nSNAP allows you to adjust the score of any
  sequence model at any point\nin a sequence. This behavior is invoked by giving a
  ZFF file to SNAP:\n    snap <hmm> <sequence> -xdef <ZFF file>\nEach feature description
  uses the 'group' field to issue a command:\n    SET     set the score\n    ADJ \
  \    adjust the score up or down\n    OK      set non-cannonical scores\n >FOO\n\
  \ Acceptor 120 120 + +50 . . . SET  (sets an Acceptor to 50)\n Donor    212 212
  + -20 . . . ADJ  (lowers a Donor by -20)\n Inter    338 579 +  -2 . . . ADJ  (lowers
  Inter by -2 in a range)\n Coding   440 512 -  +3 . . . ADJ  (raises Coding by +3
  in a range)\n Donor    625 638 +  -5 . . . OK   (sets range of odd Donors to -5)\n\
  \nTool homepage: https://github.com/SnapKit/SnapKit"
inputs:
  - id: hmm_file
    type: File
    doc: HMM file
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: FASTA file
    inputBinding:
      position: 2
  - id: aa
    type:
      - 'null'
      - boolean
    doc: report proteins to FASTA files
    inputBinding:
      position: 103
      prefix: -aa
  - id: ace
    type:
      - 'null'
      - boolean
    doc: change output to ACEDB
    inputBinding:
      position: 103
      prefix: -ace
  - id: gff
    type:
      - 'null'
      - boolean
    doc: change output to GFF
    inputBinding:
      position: 103
      prefix: -gff
  - id: lcmask
    type:
      - 'null'
      - boolean
    doc: use -lcmask to prevent exons from appearing in masked DNA
    inputBinding:
      position: 103
      prefix: -lcmask
  - id: tx
    type:
      - 'null'
      - boolean
    doc: report transcripts to FASTA files
    inputBinding:
      position: 103
      prefix: -tx
  - id: xdef
    type:
      - 'null'
      - File
    doc: External definitions ZFF file
    inputBinding:
      position: 103
      prefix: -xdef
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snap:2017_03_01--h7b50bb2_0
stdout: snap.out
