cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_phyluce_align_get_align_summary_data
label: phyluce_phyluce_align_get_align_summary_data
doc: "Compute summary statistics for alignments in parallel\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: The directory containing alignments to be summarized.
    inputBinding:
      position: 101
      prefix: --alignments
  - id: cores
    type:
      - 'null'
      - int
    doc: Process alignments in parallel using --cores for alignment. This is the
      number of PHYSICAL CPUs.
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: input_format
    type:
      - 'null'
      - string
    doc: The input alignment format.
    default: nexus
    inputBinding:
      position: 101
      prefix: --input-format
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    default: None
    inputBinding:
      position: 101
      prefix: --log-path
  - id: show_taxon_counts
    type:
      - 'null'
      - boolean
    doc: Show the count of loci with X taxa.
    default: false
    inputBinding:
      position: 101
      prefix: --show-taxon-counts
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use.
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_stats
    type:
      - 'null'
      - File
    doc: Output a CSV-formatted file of stats, by locus
    outputBinding:
      glob: $(inputs.output_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
