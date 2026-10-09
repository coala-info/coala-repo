cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - tidy
label: hicberg_tidy
doc: 'Tidy output folder.


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
