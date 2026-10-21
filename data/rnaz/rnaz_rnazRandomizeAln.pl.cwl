cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazRandomizeAln.pl
label: rnaz_rnazRandomizeAln.pl
doc: "Randomize alignments for RNAz analysis: columns of the same conservation are shuffled within windows to create a null model.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs:
  - id: input_file
    type: File
    doc: Input alignment file (ClustalW or MAF format).
    inputBinding:
      position: 1
  - id: level
    type:
      - 'null'
      - int
    doc: Level of coarse graining of the column conservation (mean pairwise identity) used to decide which columns are shuffled together (0 = conserved or not, 2 = nearly exact identity). Default is 2.
    inputBinding:
      position: 102
      prefix: --level
  - id: slide
    type:
      - 'null'
      - int
    doc: Offset of the shuffling window. Default is 120.
    inputBinding:
      position: 102
      prefix: --slide
  - id: window
    type:
      - 'null'
      - int
    doc: Size of the window in which the alignment is shuffled. Default is 120.
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz_rnazRandomizeAln.pl.out
