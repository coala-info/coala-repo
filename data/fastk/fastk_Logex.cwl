cwlVersion: v1.2
class: CommandLineTool
baseCommand: Logex
label: fastk_Logex
doc: "Combines k-mer count tables with logical expressions and filters them with count cutoffs. Each assignment name=expr writes a new table.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: '$(inputs.tables.map(function(f){return f.basename;}))'
inputs:
  - id: tables
    type: File[]
    doc: 'k-mer table stub files (.ktab), in the order of the letters A, B, C, ... used in the expressions.'
  - id: table_parts
    type: File[]
    doc: 'Hidden table part files (.<name>.ktab.N) of all the input tables.'
  - id: assignments
    type: string[]
    doc: 'Assignments <name>=<expression>, for example ''AnB = A &. B''.'
    inputBinding:
      position: 60
  - id: histograms
    type:
      - 'null'
      - string
    doc: 'Generate histograms over the range [<int>:]<int> for each assignment.'
    inputBinding:
      position: 50
      prefix: '-h'
      separate: false
  - id: histograms_only
    type:
      - 'null'
      - string
    doc: 'Generate only the histograms over the range [<int>:]<int>, no tables.'
    inputBinding:
      position: 50
      prefix: '-H'
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use -T threads. [default: 4]'
    inputBinding:
      position: 50
      prefix: '-T'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tables_out
    type:
      type: array
      items: File
    doc: Tables written for each assignment.
    outputBinding:
      glob: |
        ${
          var out = [];
          for (var i = 0; i < inputs.assignments.length; i++) {
            var n = inputs.assignments[i].split('=')[0].trim();
            out.push(n + '.ktab');
            out.push('.' + n + '.ktab.*');
          }
          return out;
        }
  - id: histograms_out
    type:
      type: array
      items: File
    doc: Histograms written for each assignment when -h or -H is used.
    outputBinding:
      glob: |
        ${
          var out = [];
          for (var i = 0; i < inputs.assignments.length; i++) {
            var n = inputs.assignments[i].split('=')[0].trim();
            out.push(n + '.hist');
          }
          return out;
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.tables)
      - $(inputs.table_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Logex.out
