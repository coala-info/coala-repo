cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_dc
label: metaxa_metaxa2_dc
doc: "Metaxa2 Diversity Tools data collector: combines several Metaxa2 level count files into one data matrix. The input files are staged in the working directory so that the sample names come from the file names, not from a full path.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input files to be processed (for example sample.level_6.txt from metaxa2_ttt)"
    inputBinding:
      position: 102
      valueFrom: $(self.map(function (f) { return f.basename; }))
  - id: output_file_path
    type: string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: -o
  - id: taxon_column
    type: ['null', int]
    doc: "Column containing taxon data, default 0"
    inputBinding:
      position: 101
      prefix: -t
  - id: count_column
    type: ['null', int]
    doc: "Column containing count data, default 1"
    inputBinding:
      position: 101
      prefix: -c
  - id: remove_string
    type: ['null', string]
    doc: "String to be removed from the file name for use as sample name; regular expressions can be used, default '.level_[0-9].txt'"
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_name_pattern
    type: ['null', string]
    doc: "Regular expression pattern for selecting the sample name from the file name, default '.*' (the full file name)"
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_file
    type: File
    doc: "Combined count table"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
