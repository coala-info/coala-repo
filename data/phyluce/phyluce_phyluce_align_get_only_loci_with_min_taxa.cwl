cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_phyluce_align_get_only_loci_with_min_taxa
label: phyluce_phyluce_align_get_only_loci_with_min_taxa
doc: "Screen a directory of alignments, only returning those containing >= --percent
  of taxa\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: The directory containing alignments to screen.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: cores
    type:
      - 'null'
      - int
    doc: Process alignments in parallel using --cores for alignment. This is the
      number of PHYSICAL CPUs.
    inputBinding:
      position: 101
      prefix: --cores
  - id: input_format
    type:
      - 'null'
      - string
    doc: The input alignment format.
    inputBinding:
      position: 101
      prefix: --input-format
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: percent
    type:
      - 'null'
      - float
    doc: The percent of taxa to require
    inputBinding:
      position: 101
      prefix: --percent
  - id: taxa
    type: int
    doc: The total number of taxa in all alignments.
    inputBinding:
      position: 101
      prefix: --taxa
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use.
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output
    type: Directory
    doc: The output dir in which to store copies of the alignments
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
