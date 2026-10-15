cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_combine_reads
label: phyluce_phyluce_utilities_combine_reads
doc: "Combine groups of reads based on an input file in config format\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ return inputs.read_dirs ? inputs.read_dirs : []; }"
inputs:
  - id: config
    type: File
    doc: "The configuration file for reads we are combining"
    inputBinding:
      position: 1
      prefix: --config
  - id: output
    type: string
    doc: "The output directory to create for the combined reads"
    inputBinding:
      position: 1
      prefix: --output
  - id: subfolder
    type:
      - 'null'
      - string
    doc: "A subdirectory, below the level of the group, containing the reads"
    inputBinding:
      position: 1
      prefix: --subfolder
  - id: read_dirs
    type:
      - 'null'
      - {"type": "array", "items": "Directory"}
    doc: "Directories of reads named in the configuration file. They are staged in the working directory, so use relative paths (the directory name) in the configuration file."
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_dir
    type: Directory
    doc: "The directory holding the combined reads"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_combine_reads.out
