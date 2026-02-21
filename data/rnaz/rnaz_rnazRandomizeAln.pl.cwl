cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnazRandomizeAln.pl
label: rnaz_rnazRandomizeAln.pl
doc: "Randomize alignments for RNAz analysis by shuffling positions, columns, or the
  entire alignment to create null models.\n\nTool homepage: https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input alignment file (usually in ClustalW or MAF format). If omitted, reads
      from stdin.
    inputBinding:
      position: 1
  - id: level
    type:
      - 'null'
      - string
    doc: "Level of randomization: 'pos' (shuffles positions within columns), 'aln'
      (shuffles the whole alignment), or 'col' (shuffles columns)."
    default: pos
    inputBinding:
      position: 102
      prefix: --level
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility. Defaults to current time if not specified.
    inputBinding:
      position: 102
      prefix: --seed
  - id: slide
    type:
      - 'null'
      - int
    doc: Slide size for windowing. 0 means no windowing.
    default: 0
    inputBinding:
      position: 102
      prefix: --slide
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for randomization. 0 means no windowing (process entire alignment).
    default: 0
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
