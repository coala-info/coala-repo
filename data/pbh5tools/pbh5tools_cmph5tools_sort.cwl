cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - sort
label: pbh5tools_cmph5tools_sort
doc: "Sort cmp.h5 files. If output-file is unspecified the input-file is overwritten.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type: File
    doc: input filename (staged writable, because the file is sorted in place when no --outFile is given)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: out_file
    type:
      - 'null'
      - string
    doc: output filename. If unspecified the input file is overwritten
    inputBinding:
      position: 100
      prefix: --outFile
  - id: deep
    type:
      - 'null'
      - boolean
    doc: whether a deep sorting should be conducted, i.e. sort the AlignmentArrays [False]
    inputBinding:
      position: 101
      prefix: --deep
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: temporary directory to use when sorting in-place [/tmp]
    inputBinding:
      position: 102
      prefix: --tmpDir
  - id: use_python_indexer
    type:
      - 'null'
      - boolean
    doc: Whether to use native indexing [False].
    inputBinding:
      position: 103
      prefix: --usePythonIndexer
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Whether to make a temporary copy of the original cmp.h5 file before sorting.
    inputBinding:
      position: 104
      prefix: --inPlace
outputs:
  - id: sorted_cmp_h5
    type: File
    doc: Sorted cmp.h5 file
    outputBinding:
      glob: '$(inputs.out_file ? inputs.out_file : inputs.input_cmp_h5.basename)'
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_sort_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_cmp_h5)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
