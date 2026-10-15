cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_remove_empty_taxa]
label: phyluce_phyluce_align_remove_empty_taxa
doc: "Remove taxa having no data from a set of input nucleotides.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
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
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, phylip-relaxed, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, phylip-relaxed, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 5
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 6
      prefix: --log-path
  - id: cores
    type: ['null', int]
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 7
      prefix: --cores
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of alignments without empty taxa."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
