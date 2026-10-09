cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - plot
label: hicberg_plot
doc: 'Plot results from analysis.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file (copied into the working directory so that the FASTA index
      can be written beside it).
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
