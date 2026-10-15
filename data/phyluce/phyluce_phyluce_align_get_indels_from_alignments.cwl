cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_indels_from_alignments]
label: phyluce_phyluce_align_get_indels_from_alignments
doc: "Count indels in alignments, relative to (but excluding) the outgroup.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output filename (without extension - code will add -TRIM.sqlite)."
    inputBinding:
      position: 2
      prefix: --output
  - id: outgroup
    type: string
    doc: "The outgroup taxon."
    inputBinding:
      position: 3
      prefix: --outgroup
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --input-format
  - id: trim
    type: ['null', string]
    doc: "Count indels only after removing gaps/missing data from alignment ends. One of: absolute, relative, none (default: absolute)."
    inputBinding:
      position: 5
      prefix: --trim
  - id: cores
    type: ['null', int]
    doc: "The number of cores to use."
    inputBinding:
      position: 6
      prefix: --cores
outputs:
  - id: indel_db
    type: File
    doc: "SQLite database of indel counts."
    outputBinding:
      glob: "$(inputs.output)-*.sqlite"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
