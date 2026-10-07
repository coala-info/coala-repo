cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - RemoveGenes
label: chewbbaca_RemoveGenes
doc: "Remove a set of loci from allele calling results.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_file
    type: File
    doc: "Path to a TSV file with allelic profiles determined by the AlleleCall process."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: genes_list
    type: File
    doc: "Path to a file with a list of genes to remove, one identifier per line."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: output_file
    type: string
    doc: "Path to the output file."
    default: "profiles_removed.tsv"
    inputBinding:
      position: 1
      prefix: --output-file
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: "If provided, the genes included in the list will be kept, and all other genes will be removed."
    inputBinding:
      position: 1
      prefix: --inverse
outputs:
  - id: output
    type: File
    doc: "Allelic profiles without the removed loci."
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
