cwlVersion: v1.2
class: CommandLineTool
baseCommand: Symmex
label: fastk_Symmex
doc: "Makes a k-mer table symmetric: it adds the reverse complement of each k-mer so both strands are present.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: $(inputs.table.basename)
inputs:
  - id: table
    type: File
    doc: k-mer table stub file (.ktab) made by FastK.
  - id: table_parts
    type: File[]
    doc: 'Hidden table part files (.<name>.ktab.N) made by FastK; they are staged beside the stub.'
  - id: dest
    type: string
    doc: 'Name of the new table stub (<name>.ktab).'
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, output statistics as proceed.'
    inputBinding:
      position: 50
      prefix: '-v'
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use -T threads. [default: 4]'
    inputBinding:
      position: 50
      prefix: '-T'
      separate: false
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Place all temporary files in directory -P. [default: /tmp]'
    inputBinding:
      position: 50
      prefix: '-P'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dest_table
    type:
      type: array
      items: File
    doc: New table stub and hidden parts.
    outputBinding:
      glob: |
        ${
          var s = inputs.dest.replace(/\.ktab$/, '');
          return [s + '.ktab', '.' + s + '.ktab.*'];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.table)
      - $(inputs.table_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Symmex.out
