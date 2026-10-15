cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_get_trinity_coverage
label: phyluce_phyluce_assembly_get_trinity_coverage
doc: "Get coverage of UCE assemblies from Trinity\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.assemblies)
        writable: true
      - "${ return inputs.read_dirs ? inputs.read_dirs : []; }"
inputs:
  - id: assemblies
    type: Directory
    doc: "The directory containing the assemblies. It is staged writable, because the tool writes alignments and coverage files into it."
    inputBinding:
      position: 1
      prefix: --assemblies
      valueFrom: $(self.basename)
  - id: assemblo_config
    type:
      - 'null'
      - File
    doc: "The assemblo_trinity configuration file"
    inputBinding:
      position: 1
      prefix: --assemblo-config
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of compute cores/threads to run with Trinity"
    inputBinding:
      position: 1
      prefix: --cores
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
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Cleanup all intermediate Trinity files"
    inputBinding:
      position: 1
      prefix: --clean
  - id: bwa_mem
    type:
      - 'null'
      - boolean
    doc: "Use bwa-mem instead of standard bwa"
    inputBinding:
      position: 1
      prefix: --bwa-mem
  - id: assembler
    type:
      - 'null'
      - string
    doc: "Program used to asemble raw reads (velvet, abyss, trinity, trinity2, idba or spades)"
    inputBinding:
      position: 1
      prefix: --assembler
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "Trim contigs to a minimum coverage amount"
    inputBinding:
      position: 1
      prefix: --trim
  - id: read_dirs
    type:
      - 'null'
      - {"type": "array", "items": "Directory"}
    doc: "Directories of reads named in the configuration file. They are staged in the working directory, so use relative paths (the directory name) in the configuration file."
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: assemblies_out
    type: Directory
    doc: "The assemblies directory with the added coverage files"
    outputBinding:
      glob: $(inputs.assemblies.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_get_trinity_coverage.out
