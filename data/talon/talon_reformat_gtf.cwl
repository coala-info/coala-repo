cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_reformat_gtf
label: talon_reformat_gtf
doc: "Fix a GTF that has no gene records.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: gtf
    type: File
    doc: gtf to fix
    inputBinding:
      position: 101
      prefix: -gtf
outputs:
  - id: reformatted_gtf
    type: File
    doc: GTF with gene records added
    outputBinding:
      glob: $(inputs.gtf.nameroot)_reformatted.gtf
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gtf)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_reformat_gtf.out
