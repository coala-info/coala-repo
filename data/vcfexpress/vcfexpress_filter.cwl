cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfexpress_filter
label: vcfexpress_filter
doc: "Filter a VCF/BCF and optionally print by template expression. If no template
  is given the output will be VCF/BCF\n\nTool homepage: https://github.com/brentp/vcfexpress/"
inputs:
  - id: path
    type: File
    doc: Path to input VCF or BCF file
    inputBinding:
      position: 1
  - id: expression
    type:
      - 'null'
      - string
    doc: boolean Lua expression(s) to filter the VCF or BCF file
    inputBinding:
      position: 102
      prefix: --expression
  - id: lua_prelude
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) containing lua(u) code to run once before any variants are 
      processed. `header` is available here to access or modify the header
    inputBinding:
      position: 102
      prefix: --lua-prelude
  - id: sandbox
    type:
      - 'null'
      - boolean
    doc: Run lua code in https://luau.org/sandbox
    inputBinding:
      position: 102
      prefix: --sandbox
  - id: set_expression
    type:
      - 'null'
      - string
    doc: expression(s) to set existing INFO field(s) (new ones can be added in 
      prelude) e.g. --set-expression "AFmax=math.max(variant:info('AF'), 
      variant:info('AFx'))"
    inputBinding:
      position: 102
      prefix: --set-expression
  - id: template
    type:
      - 'null'
      - string
    doc: "template expression in luau: https://luau-lang.org/syntax#string-interpolation.
      e.g. '{variant.chrom}:{variant.pos}'"
    inputBinding:
      position: 102
      prefix: --template
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Optional output file. Default is stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfexpress:0.3.4--h3ab6199_0
