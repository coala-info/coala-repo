cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapless.py
  - extend
label: gapless_extend
doc: "Extend scaffold ends with reads reaching over the ends.\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: scaffold_files
    type:
      type: array
      items: File
    doc: "Files written by the scaffold step (prefix*), staged in the working directory so the prefix resolves"
  - id: prefix
    type: string
    doc: "Prefix for output files of scaffolding step (mandatory)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: min_len_break
    type:
      - 'null'
      - int
    doc: "Minimum length for two reads to diverge to consider them incompatible for this contig (1000)"
    inputBinding:
      position: 1
      prefix: --minLenBreak
  - id: all_vs_all
    type: File
    doc: "All-versus-all mapping of the extending reads ({all_vs_all}.paf)"
    inputBinding:
      position: 2
outputs:
  - id: extended_files
    type:
      type: array
      items: File
    doc: Extended scaffold files written with the prefix
    outputBinding:
      glob:
        - $(inputs.prefix)_extended*
        - $(inputs.prefix)_used_reads.lst
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.scaffold_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
