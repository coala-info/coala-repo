cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - get-tables
label: hicberg_get-tables
doc: 'Create tables for the genome length detail and the bins.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: bins
    type:
      - 'null'
      - int
    doc: Genomic resolution.
    inputBinding:
      position: 104
      prefix: --bins
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
