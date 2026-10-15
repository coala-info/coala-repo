cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_assemblo_velvet
label: phyluce_phyluce_assembly_assemblo_velvet
doc: "Assemble raw reads using velvet\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ return inputs.read_dirs ? inputs.read_dirs : []; }"
inputs:
  - id: output
    type: string
    doc: "The directory in which to store the assembly data"
    inputBinding:
      position: 1
      prefix: --output
  - id: kmer
    type:
      - 'null'
      - int
    doc: "The kmer value to use"
    inputBinding:
      position: 1
      prefix: --kmer
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of compute cores/threads to run with Velvet"
    inputBinding:
      position: 1
      prefix: --cores
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Cleanup all intermediate Velvet files"
    inputBinding:
      position: 1
      prefix: --clean
  - id: subfolder
    type:
      - 'null'
      - string
    doc: "A subdirectory, below the level of the group, containing the reads"
    inputBinding:
      position: 1
      prefix: --subfolder
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
  - id: config
    type:
      - 'null'
      - File
    doc: "A configuration file containing reads to assemble (use this or --dir)"
    inputBinding:
      position: 1
      prefix: --config
  - id: dir
    type:
      - 'null'
      - Directory
    doc: "A directory of reads to assemble (use this or --config)"
    inputBinding:
      position: 1
      prefix: --dir
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
    type:
      - 'null'
      - Directory
    doc: "The directory in which to store the assembly data"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_assemblo_velvet.out
