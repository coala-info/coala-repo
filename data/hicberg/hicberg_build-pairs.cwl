cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - build-pairs
label: hicberg_build-pairs
doc: 'Create pair files from a pair of alignment files.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: recover
    type:
      - 'null'
      - boolean
    doc: Set if pairs are built after reads reassignment. Therefore alignment files
      of group2 will be used.
    inputBinding:
      position: 104
      prefix: --recover
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
