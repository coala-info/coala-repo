cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_explode_get_fastas_file
label: phyluce_phyluce_assembly_explode_get_fastas_file
doc: "Explode the fasta file produced by get_fastas_from_match_counts into single files\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The input fasta file to explode"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The output directory to create and in which to store the fastas"
    inputBinding:
      position: 1
      prefix: --output
  - id: by_taxon
    type:
      - 'null'
      - boolean
    doc: "Split file by taxon and not by locus"
    inputBinding:
      position: 1
      prefix: --by-taxon
  - id: split_char
    type:
      - 'null'
      - string
    doc: "The character to split on"
    inputBinding:
      position: 1
      prefix: --split-char
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the exploded fasta files"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_explode_get_fastas_file.out
