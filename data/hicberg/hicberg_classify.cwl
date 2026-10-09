cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - classify
label: hicberg_classify
doc: "Perform classification of Hi-C reads (pairs). 3 groups wil be defined and 2\
  \ alignment files (.bam) will be created per group:\n\n  - Unmapped read pairs (group\
  \ 0)\n\n  - Read pairs with both reads mapping at only one position (group 1)\n\n\
  \  - Read pairs with at least one read mapping at multiple positions (group 2)\n\
  \nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read as non ambiguous.
    inputBinding:
      position: 104
      prefix: --mapq
outputs:
  - id: output_folder_out
    type: Directory
    doc: The same result folder with the files this stage wrote.
    outputBinding:
      glob: $(inputs.output_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
