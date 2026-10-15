cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_extract_taxon_fasta_from_alignments]
label: phyluce_phyluce_align_extract_taxon_fasta_from_alignments
doc: "From a set of input alignments, create a FASTA file of all sequences associated with a given taxon.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory of alignments."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: taxon
    type: string
    doc: "The taxon to extract."
    inputBinding:
      position: 2
      prefix: --taxon
  - id: output
    type: string
    doc: "The output FASTA file."
    inputBinding:
      position: 3
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input format of the alignments. One of: nexus, newick, fasta, phylip (default: nexus)."
    inputBinding:
      position: 4
      prefix: --input-format
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
outputs:
  - id: output_fasta
    type: File
    doc: "FASTA file of the taxon's sequences, one per locus."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
