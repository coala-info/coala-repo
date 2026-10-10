cwlVersion: v1.2
class: CommandLineTool
baseCommand: KatComp
label: merquryfk_KatComp
doc: "Compares the k-mer spectra of two k-mer tables (KatComp of MerquryFK)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        function add(f, parts) {
          if (!f) { return; }
          l.push({entryname: f.basename, entry: f});
          (parts || []).forEach(function (p) {
            var n = p.basename.split('.').pop();
            l.push({entryname: '.' + f.basename + '.' + n, entry: p});
          });
        }
        add(inputs.source1, inputs.source1_parts);
        add(inputs.source2, inputs.source2_parts);
        return l;
      }
inputs:
  - id: source1
    type: File
    doc: "First k-mer table (<source1>.ktab)"
    inputBinding:
      position: 1
  - id: source1_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: source2
    type: File
    doc: "Second k-mer table (<source2>.ktab)"
    inputBinding:
      position: 2
  - id: source2_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: out_prefix
    type: string
    doc: "Output name prefix of the plots"
    inputBinding:
      position: 3
  - id: width
    type:
      - 'null'
      - float
    doc: "width in inches of plots"
    inputBinding:
      position: 100
      prefix: -w
      separate: false
  - id: height
    type:
      - 'null'
      - float
    doc: "height in inches of plots"
    inputBinding:
      position: 100
      prefix: -h
      separate: false
  - id: max_x_multiple
    type:
      - 'null'
      - float
    doc: "max x as a real-valued multiple of x* with max count 'peak' away from the origin"
    inputBinding:
      position: 100
      prefix: -x
      separate: false
  - id: max_x_absolute
    type:
      - 'null'
      - int
    doc: "max x as an int value in absolute terms"
    inputBinding:
      position: 100
      prefix: -X
      separate: false
  - id: max_y_multiple
    type:
      - 'null'
      - float
    doc: "max y as a real-valued multiple of y* with max count 'peak' away from the origin"
    inputBinding:
      position: 100
      prefix: -y
      separate: false
  - id: max_y_absolute
    type:
      - 'null'
      - int
    doc: "max y as an int value in absolute terms"
    inputBinding:
      position: 100
      prefix: -Y
      separate: false
  - id: draw_line_plot
    type:
      - 'null'
      - boolean
    doc: "draw line plot"
    inputBinding:
      position: 100
      prefix: -l
  - id: draw_fill_plot
    type:
      - 'null'
      - boolean
    doc: "draw fill plot"
    inputBinding:
      position: 100
      prefix: -f
  - id: draw_stack_plot
    type:
      - 'null'
      - boolean
    doc: "draw stack plot"
    inputBinding:
      position: 100
      prefix: -s
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: "output .pdf (default is .png)"
    inputBinding:
      position: 100
      prefix: -pdf
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use"
    inputBinding:
      position: 100
      prefix: -T
      separate: false
outputs:
  - id: figures_png
    type: File[]
    doc: "Plot files (PNG; empty with -pdf)"
    outputBinding:
      glob: $(inputs.out_prefix)*.png
  - id: figures_pdf
    type: File[]
    doc: "Plot files (PDF; empty without -pdf)"
    outputBinding:
      glob: $(inputs.out_prefix)*.pdf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
