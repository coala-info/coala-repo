cwlVersion: v1.2
class: CommandLineTool
baseCommand: KatGC
label: merquryfk_KatGC
doc: "Plots k-mer coverage against GC content of a k-mer table (KatGC of MerquryFK)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
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
        add(inputs.source, inputs.source_parts);
        return l;
      }
inputs:
  - id: source
    type: File
    doc: "FastK k-mer table (<source>.ktab)"
    inputBinding:
      position: 1
  - id: source_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: out_prefix
    type: string
    doc: "Output name prefix of the plots"
    inputBinding:
      position: 2
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
  - id: draw_contour_map
    type:
      - 'null'
      - boolean
    doc: "draw a contour map"
    inputBinding:
      position: 100
      prefix: -l
  - id: draw_heat_map
    type:
      - 'null'
      - boolean
    doc: "draw a heat map"
    inputBinding:
      position: 100
      prefix: -f
  - id: draw_heat_map_contour
    type:
      - 'null'
      - boolean
    doc: "draw a heat map with contour overlay"
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
