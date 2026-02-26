cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgatools_validate
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
    default: false
    inputBinding:
      position: 102
      prefix: --rewrite
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads, default 1
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be 
      compressed automatically
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
