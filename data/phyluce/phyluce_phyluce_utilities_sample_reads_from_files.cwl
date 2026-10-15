cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_sample_reads_from_files
label: phyluce_phyluce_utilities_sample_reads_from_files
doc: "Sample reads from files (with seqtk) according to a configuration file\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ return inputs.read_files ? inputs.read_files : []; }"
inputs:
  - id: conf
    type: File
    doc: "The path to the config file giving reads to sample"
    inputBinding:
      position: 1
      prefix: --conf
  - id: output
    type: string
    doc: "The path to output directory"
    inputBinding:
      position: 1
      prefix: --output
  - id: read_files
    type:
      - 'null'
      - {"type": "array", "items": "File"}
    doc: "Read files named in the configuration file. They are staged in the working directory, so use relative paths (the file name) in the configuration file."
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the sampled reads"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_sample_reads_from_files.out
