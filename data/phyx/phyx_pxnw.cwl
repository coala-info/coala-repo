cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxnw]
label: phyx_pxnw
doc: |-
  Conduct Needleman-Wunsch analysis for all the seqs in a file.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
  Output is a list of the scores and distances (and the alignments if asked).

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input sequence file (fasta, fastq, phylip or nexus)"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: ['null', string]
    doc: "output score/distance file name (pxnw ignores this option: the scores go to standard output and this file stays empty)"
    inputBinding:
      prefix: -o
  - id: out_aln_file_path
    type: ['null', string]
    doc: "output sequence file name, won't output otherwise (pxnw ignores this option and writes no alignment file)"
    inputBinding:
      prefix: -a
  - id: seqtype
    type: ['null', int]
    doc: "sequence type, default=DNA (DNA=0,AA=1)"
    inputBinding:
      prefix: -t
  - id: matrix
    type: ['null', File]
    doc: "scoring matrix, default DNA=EDNAFULL, AA=BLOSUM62 (the AA default matrix is not implemented: with seqtype 1 and no matrix all scores are 0)"
    inputBinding:
      prefix: -m
  - id: nthreads
    type: ['null', int]
    doc: "number of threads (open mp), default=2"
    inputBinding:
      prefix: -n
  - id: verbose
    type: ['null', boolean]
    doc: "make the output more verbose, turns off parallel"
    inputBinding:
      prefix: -v
outputs:
  - id: out_file
    type: ['null', File]
    doc: "score/distance list (pxnw ignores this option: the scores go to standard output and this file stays empty)"
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: out_aln_file
    type: ['null', File]
    doc: "alignments (only when an output name is given)"
    outputBinding:
      glob: $(inputs.out_aln_file_path)
  - id: stdout_text
    type: stdout
    doc: "standard output (scores and distances for pxnw; alignments with verbose)"
stdout: pxnw.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
