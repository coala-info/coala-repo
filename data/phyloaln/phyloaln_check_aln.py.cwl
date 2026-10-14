cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - check_aln.py
label: phyloaln_check_aln.py
doc: "Check alignments by the average frequency of the most common character per site and by gaps at the alignment ends, and copy the good ones.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_dir
    type: Directory
    doc: "directory with the input FASTA alignments"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "output directory of the alignments that pass the check (default='none': only report)"
    default: "none"
    inputBinding:
      position: 2
  - id: aver_freq_per_site
    type: float
    doc: "minimum average frequency per site (default 0.75)"
    default: 0.75
    inputBinding:
      position: 3
  - id: gap_symbol
    type: string
    doc: "gap symbol (default='-')"
    default: "-"
    inputBinding:
      position: 4
  - id: start_end_no_gap
    type: float
    doc: "number (>=1) or percent (<1) of sequences without gap at the start and end of the alignment (default 0.6)"
    default: 0.6
    inputBinding:
      position: 5
  - id: fasta_suffix
    type: string
    doc: "suffix of the input FASTA files (default='.fa')"
    default: ".fa"
    inputBinding:
      position: 6
outputs:
  - id: passed_dir
    type:
      - 'null'
      - Directory
    doc: "Alignments that pass the check (only when output_dir is not none)"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_check_aln.py.out
