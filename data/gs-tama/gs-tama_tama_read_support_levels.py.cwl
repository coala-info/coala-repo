cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_read_support_levels.py
label: gs-tama_tama_read_support_levels.py
doc: "This script produces a read support file for identifying what models are supported by which reads\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: file_list
    type: File
    doc: "Filelist file with pre-merge trans_read.bed file names (tab separated: source name, trans_read.bed file name, file type)"
    inputBinding:
      position: 101
      prefix: -f
  - id: merge_file
    type:
      - File
      - string
    doc: "Merge.txt file from after merging. Use \"no_merge\" if there is no merge file."
    inputBinding:
      position: 101
      prefix: -m
  - id: output_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: ignore_duplicate_read_names
    type:
      - 'null'
      - string
    doc: "Ignore duplicate read name warning with dup_ok, default is to flag duplicates and terminate early."
    inputBinding:
      position: 101
      prefix: -d
  - id: merge_type
    type:
      - 'null'
      - string
    doc: "Merge type flag indicates the type of merge file used. Use cupcake for cupcake file. Default is TAMA output."
    inputBinding:
      position: 101
      prefix: -mt
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the file list (for example the trans_read.bed files); they are staged in the working directory so that the names in the file list resolve"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_read_support_levels.py.out
