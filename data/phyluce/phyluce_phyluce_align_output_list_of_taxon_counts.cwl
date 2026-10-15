cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_output_list_of_taxon_counts]
label: phyluce_phyluce_align_output_list_of_taxon_counts
doc: "Compute summary statistics for alignments in parallel; list FASTA files with fewer taxa than a minimum.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: fastas
    type: Directory
    doc: "The directory containing fastas to be checked."
    inputBinding:
      position: 1
      prefix: --fastas
  - id: input_format
    type: ['null', string]
    doc: "The input file format (only fasta; default: fasta)."
    inputBinding:
      position: 2
      prefix: --input-format
  - id: min_count
    type: ['null', int]
    doc: "The min count of taxa allowed in a fasta file (default: 3)."
    inputBinding:
      position: 3
      prefix: --min-count
  - id: cores
    type: ['null', int]
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 4
      prefix: --cores
outputs:
  - id: short_files
    type: stdout
    doc: "Names of FASTA files that contain fewer taxa than --min-count."
stdout: phyluce_align_output_list_of_taxon_counts.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
