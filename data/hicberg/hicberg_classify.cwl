cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg classify
label: hicberg_classify
doc: "Perform classification of Hi-C reads (pairs). 3 groups wil be defined and 2
  alignment files (.bam) will be created per group:\n\n  - Unmapped read pairs (group
  0)\n\n  - Read pairs with both reads mapping at only one position (group 1)\n\n\
  \  - Read pairs with at least one read mapping at multiple positions (group 2)\n\
  \nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read as non ambiguous.
    inputBinding:
      position: 101
      prefix: --mapq
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
