cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - convert
label: cpstools_convert
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_dir)
doc: "Convert genbank format files to other formats.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_dir
    type: Directory
    doc: Input path of genbank file
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: mode
    type:
      type: enum
      symbols:
        - fasta
        - mVISTA
        - tbl
        - ge2gb
    doc: 'Mode: fasta for converse genbank format file into fasta format file; mVISTA
      for converse genbank format file into mVISTA format file; tbl for converse genbank
      format file into tbl format file'
    inputBinding:
      position: 101
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_dir
    type: Directory
    doc: Converted files, written to a folder named after the mode beside the input folder
    outputBinding:
      glob: $(inputs.mode)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_convert.out
