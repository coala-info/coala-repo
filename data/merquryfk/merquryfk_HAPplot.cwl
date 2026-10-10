cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAPplot
label: merquryfk_HAPplot
doc: "Plots hap-mer blob plots of one or two assemblies (HAPplot of MerquryFK)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
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
        add(inputs.mat, inputs.mat_parts);
        add(inputs.pat, inputs.pat_parts);
        return l;
      }
inputs:
  - id: mat
    type: File
    doc: "Maternal hap-mer table (<mat>.hap.ktab)"
    inputBinding:
      position: 1
  - id: mat_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: pat
    type: File
    doc: "Paternal hap-mer table (<pat>.hap.ktab)"
    inputBinding:
      position: 2
  - id: pat_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: asm1
    type: File
    doc: "First assembly (dna: FASTA/FASTQ, optionally gzipped)"
    inputBinding:
      position: 3
  - id: asm2
    type:
      - 'null'
      - File
    doc: "Second assembly (dna)"
    inputBinding:
      position: 4
  - id: out_prefix
    type: string
    doc: "Output name; <out>.hpi is written with -k, plots are <out>.*.png or <out>.*.pdf"
    inputBinding:
      position: 5
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
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: "output .pdf (default is .png)"
    inputBinding:
      position: 100
      prefix: -pdf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output to stderr"
    inputBinding:
      position: 100
      prefix: -v
  - id: keep_plotting_data
    type:
      - 'null'
      - boolean
    doc: "keep plotting data as <out>.hpi for a later go"
    inputBinding:
      position: 100
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use"
    inputBinding:
      position: 100
      prefix: -T
      separate: false
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: "Place all temporary files in directory -P."
    inputBinding:
      position: 100
      prefix: -P
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
  - id: plot_data
    type: File[]
    doc: "Plotting data kept with -k"
    outputBinding:
      glob: $(inputs.out_prefix).hpi*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
