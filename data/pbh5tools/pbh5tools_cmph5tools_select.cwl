cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - select
label: pbh5tools_cmph5tools_select
doc: "Create a new cmp.h5 file by selecting alignments. Users can specify indices using the idx argument to select particular alignments, or a where expression. If a groupBy expression is specified then multiple cmp.h5 files are generated according to the expression.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type: File
    doc: input.cmp.h5
    inputBinding:
      position: 1
  - id: out_file
    type:
      - 'null'
      - string
    doc: Either a pattern string or a filename (--outFile out.cmp.h5)
    inputBinding:
      position: 100
      prefix: --outFile
  - id: idxs
    type:
      - 'null'
      - type: array
        items: int
    doc: indices to select
    inputBinding:
      position: 101
      prefix: --idxs
  - id: group_by
    type:
      - 'null'
      - string
    doc: groupBy expression, e.g., Movie*Barcode
    inputBinding:
      position: 102
      prefix: --groupBy
  - id: group_by_csv
    type:
      - 'null'
      - File
    doc: groupByCsv file, e.g. Group,Movie,Barcode\ngroupname,movie,barcode
    inputBinding:
      position: 103
      prefix: --groupByCsv
  - id: where
    type:
      - 'null'
      - string
    doc: where expression, e.g., ReadLength > 500
    inputBinding:
      position: 104
      prefix: --where
  - id: out_dir
    type:
      - 'null'
      - string
    doc: Output directory (created by the tool when it does not exist)
    inputBinding:
      position: 105
      prefix: --outDir
outputs:
  - id: selected_cmp_h5
    type:
      type: array
      items: File
    doc: New cmp.h5 files with the selected alignments
    outputBinding:
      glob: |
        ${ return inputs.out_dir ? inputs.out_dir + "/*.cmp.h5" : "*.cmp.h5"; }
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_select_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.out_dir ? [{"entryname": inputs.out_dir, "entry": {"class": "Directory", "listing": []}, "writable": true}] : []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
