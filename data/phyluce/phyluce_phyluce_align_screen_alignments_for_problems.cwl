cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_screen_alignments_for_problems]
label: phyluce_phyluce_align_screen_alignments_for_problems
doc: "Screen a given set of alignments for problematic nucleotides.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing alignments to be screened."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The directory in which to store the resulting alignments."
    inputBinding:
      position: 2
      prefix: --output
  - id: do_not_screen_n
    type: ['null', boolean]
    doc: "Do not screen alignments for taxa containing ambiguous (N) bases."
    inputBinding:
      position: 3
      prefix: --do-not-screen-n
  - id: do_not_screen_x
    type: ['null', boolean]
    doc: "Do not screen alignments for taxa containing ambiguous (X) bases."
    inputBinding:
      position: 4
      prefix: --do-not-screen-x
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 5
      prefix: --input-format
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 6
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 7
      prefix: --log-path
  - id: cores
    type: ['null', int]
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 8
      prefix: --cores
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of alignments that passed the screen."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
