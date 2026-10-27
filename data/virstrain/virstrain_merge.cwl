cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virstrain_merge
label: virstrain_merge
doc: "Merge read-based VirStrain databases into one contig database.\n\nTool homepage:
  https://github.com/liaoherui/VirStrain"
inputs:
  - id: merge_db
    type: Directory[]
    doc: 'Dirs of VirStrain databases to merge, e.g. VirStrain_DB/SCOV2 and VirStrain_DB/H1N1
      (joined by commas on the command line) --- Required'
    inputBinding:
      position: 1
      prefix: --merge_db
      itemSeparator: ','
  - id: out_dir
    type:
      - 'null'
      - string
    doc: 'Output dir of merged database. (default: current dir/VirStrain_DB_merge)'
    inputBinding:
      position: 2
      prefix: --output_dir
outputs:
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: 'Output dir of merged database. (default: current dir/VirStrain_DB_merge)'
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain_merge.out
