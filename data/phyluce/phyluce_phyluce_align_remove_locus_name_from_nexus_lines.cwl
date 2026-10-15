cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_remove_locus_name_from_nexus_lines]
label: phyluce_phyluce_align_remove_locus_name_from_nexus_lines
doc: "Remove the UCE locus name from nexus alignments.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input directory containing nexus files to filter."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output directory to hold the converted nexus files."
    inputBinding:
      position: 2
      prefix: --output
  - id: taxa
    type: ['null', int]
    doc: "The expected number of taxa in all alignments."
    inputBinding:
      position: 3
      prefix: --taxa
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 5
      prefix: --output-format
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
    doc: "Directory of alignments with the locus name removed from taxon names."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
