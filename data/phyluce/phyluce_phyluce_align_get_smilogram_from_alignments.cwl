cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_smilogram_from_alignments]
label: phyluce_phyluce_align_get_smilogram_from_alignments
doc: "Record variant positions in alignments.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output filename (without extension - code will add .sqlite)."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: cores
    type: ['null', int]
    doc: "The number of cores to use."
    inputBinding:
      position: 4
      prefix: --cores
  - id: smilogram
    type: ['null', boolean]
    doc: "Prepare output for smilogram figure."
    inputBinding:
      position: 5
      prefix: --smilogram
outputs:
  - id: variant_db
    type: File
    doc: "SQLite database of variant positions."
    outputBinding:
      glob: "$(inputs.output).sqlite"
  - id: smilogram_csv
    type: ['null', File]
    doc: "Substitution counts by distance from the locus center (with --smilogram)."
    outputBinding:
      glob: "$(inputs.output)-smilogram.csv"
  - id: missing_csv
    type: ['null', File]
    doc: "Missing data counts by distance from the locus center (with --smilogram)."
    outputBinding:
      glob: "$(inputs.output)-missing.csv"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
