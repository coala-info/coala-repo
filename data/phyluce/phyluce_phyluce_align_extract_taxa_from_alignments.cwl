cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_extract_taxa_from_alignments]
label: phyluce_phyluce_align_extract_taxa_from_alignments
doc: "Create a new set of alignments from an old set of alignments by excluding or keeping certain taxa.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input directory containing alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The directory in which to store the output files."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input format of the alignments. One of: nexus, newick, fasta, phylip (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, phylip-relaxed, phylip-sequential, clustal, emboss, stockholm (default: fasta)."
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
  - id: skip_check
    type: ['null', boolean]
    doc: "Skip the initial taxon determination."
    inputBinding:
      position: 8
      prefix: --skip-check
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa to exclude (cannot be used with --include)."
    inputBinding:
      position: 9
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa to include (cannot be used with --exclude)."
    inputBinding:
      position: 10
      prefix: --include
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of alignments with the chosen taxa."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
