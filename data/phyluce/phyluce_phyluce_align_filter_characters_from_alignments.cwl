cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_filter_characters_from_alignments]
label: phyluce_phyluce_align_filter_characters_from_alignments
doc: "For a given folder of alignments, replace masked bases and/or insertion characters and convert to FASTA sequence files.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input alignment files to filter."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output folder for the FASTA files (the folder is created before the run)."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
outputs:
  - id: output_dir
    type: Directory
    doc: "Folder of FASTA files with masked bases and gaps removed."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.output, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
