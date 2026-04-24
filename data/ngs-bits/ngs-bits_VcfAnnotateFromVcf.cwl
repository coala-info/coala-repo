cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateFromVcf
label: ngs-bits_VcfAnnotateFromVcf
doc: "Annotates a VCF file with data from one or more source VCF files.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: allow_missing_header
    type:
      - 'null'
      - boolean
    doc: If set the execution is not aborted if a INFO header is missing in the 
      source file.
    inputBinding:
      position: 101
      prefix: -allow_missing_header
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of lines processed in one chunk.
    inputBinding:
      position: 101
      prefix: -block_size
  - id: config_file
    type:
      - 'null'
      - File
    doc: 'TSV file for annotation from multiple source files. For each source file,
      these tab-separated columns have to be given: source file name, prefix, INFO
      keys, ID column.'
    inputBinding:
      position: 101
      prefix: -config_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enables debug output (use only with one thread).
    inputBinding:
      position: 101
      prefix: -debug
  - id: existence_key_name
    type:
      - 'null'
      - string
    doc: Defines the INFO key name.
    inputBinding:
      position: 101
      prefix: -existence_key_name
  - id: existence_only
    type:
      - 'null'
      - boolean
    doc: Only annotate if variant exists in source.
    inputBinding:
      position: 101
      prefix: -existence_only
  - id: hts_version
    type:
      - 'null'
      - boolean
    doc: Prints used htlib version and exits.
    inputBinding:
      position: 101
      prefix: -hts_version
  - id: id_column
    type:
      - 'null'
      - string
    doc: ID column in 'source' (must be 'ID'). If unset, the ID column is not 
      annotated. Alternative output name can be specified by using 
      'ID=new_name'.
    inputBinding:
      position: 101
      prefix: -id_column
  - id: info_keys
    type:
      - 'null'
      - string
    doc: "INFO key(s) in 'source' that should be annotated (Multiple keys are be separated
      by ',', optional keys can be renamed using this syntax: 'original_key=new_key')."
    inputBinding:
      position: 101
      prefix: -info_keys
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input VCF(.GZ) file that is annotated. If unset, reads from STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: prefetch
    type:
      - 'null'
      - int
    doc: Maximum number of chunks that may be pre-fetched into memory.
    inputBinding:
      position: 101
      prefix: -prefetch
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix added to all annotations in the output VCF file.
    inputBinding:
      position: 101
      prefix: -prefix
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: source
    type:
      - 'null'
      - File
    doc: Tabix indexed VCF.GZ file that is the source of the annotated data.
    inputBinding:
      position: 101
      prefix: -source
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used to process VCF lines.
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output VCF file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
