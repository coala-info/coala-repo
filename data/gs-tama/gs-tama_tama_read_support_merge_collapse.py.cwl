cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_read_support_merge_collapse.py
label: gs-tama_tama_read_support_merge_collapse.py
doc: "This script finds all read support for transcripts in tama merge output\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: merge_file
    type: File
    doc: TAMA merge output file (prefix_merge.txt)
    inputBinding:
      position: 1
  - id: file_list
    type: File
    doc: "Filelist file (tab separated: read support file name, source prefix, directory path that ends with / and is joined to the file name; use ./ for the working directory)"
    inputBinding:
      position: 2
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 3
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Read support files named in the file list (made by tama_read_support_collapse_cluster); they are staged in the working directory so that the names in the file list resolve"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Read support file for the merged transcripts
    outputBinding:
      glob: $(inputs.output_file_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_read_support_merge_collapse.py.out
