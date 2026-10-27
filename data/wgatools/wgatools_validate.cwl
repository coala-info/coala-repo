cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgatools
  - validate
label: wgatools_validate
doc: "Validate and fix query&target position in PAF file by CIGAR\n\nTool homepage:
  https://github.com/wjwei-handsome/wgatools"
inputs:
  - id: input_paf_file
    type:
      - 'null'
      - File
    doc: Input PAF File, None for STDIN
    inputBinding:
      position: 1
  - id: fix_output_file
    type:
      - 'null'
      - string
    doc: Fixed output file, None for NOT FIX, `-` will mix newoutput & 
      information
    inputBinding:
      position: 102
      prefix: --fix
  - id: rewrite
    type:
      - 'null'
      - boolean
    doc: Bool, if rewrite output file
    inputBinding:
      position: 102
      prefix: --rewrite
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads, default 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Logging level: -v gives Info (default: Warn)'
    inputBinding:
      position: 102
      prefix: -v
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: 'Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed
      automatically [default: -]'
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Validation report (when outfile_path is not set)
  - id: fix_output
    type:
      - 'null'
      - File
    doc: Fixed PAF file
    outputBinding:
      glob: $(inputs.fix_output_file)
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be 
      compressed automatically
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
stdout: wgatools_validate.out
