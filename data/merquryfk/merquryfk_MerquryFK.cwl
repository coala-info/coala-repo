cwlVersion: v1.2
class: CommandLineTool
baseCommand: MerquryFK
label: merquryfk_MerquryFK
doc: "K-mer based assembly evaluation: completeness, QV, copy-number and phasing plots (MerquryFK)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
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
        add(inputs.reads, inputs.reads_parts);
        add(inputs.mat, inputs.mat_parts);
        add(inputs.pat, inputs.pat_parts);
        l.push({entryname: inputs.reads.basename.replace(/\.ktab$/, '') + '.hist', entry: inputs.reads_hist});
        return l;
      }
inputs:
  - id: reads
    type: File
    doc: "FastK k-mer table of the reads (<read>.ktab)"
    inputBinding:
      position: 1
  - id: reads_parts
    type: File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: reads_hist
    type: File
    doc: FastK histogram of the reads (<read>.hist), staged beside the k-mer table
  - id: mat
    type:
      - 'null'
      - File
    doc: "Maternal hap-mer table (trio mode, <mat>.hap.ktab)"
    inputBinding:
      position: 2
  - id: mat_parts
    type:
      - 'null'
      - File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: pat
    type:
      - 'null'
      - File
    doc: "Paternal hap-mer table (trio mode, <pat>.hap.ktab)"
    inputBinding:
      position: 3
  - id: pat_parts
    type:
      - 'null'
      - File[]
    doc: Hidden part files of the table (.<name>.ktab.1, .<name>.ktab.2, ...) written beside the table
  - id: asm1
    type: File
    doc: "First assembly (dna: FASTA/FASTQ, optionally gzipped)"
    inputBinding:
      position: 4
  - id: asm2
    type:
      - 'null'
      - File
    doc: "Second assembly (dna)"
    inputBinding:
      position: 5
  - id: out_prefix
    type: string
    doc: "Output name prefix; writes <out>.completeness.stats, <out>.qv.stats and plots"
    inputBinding:
      position: 6
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
    doc: "max y as a real-valued multiple of max count 'peak' away from the origin"
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
  - id: plot_unique_kmers
    type:
      - 'null'
      - boolean
    doc: "plot counts of k-mers unique to the assembly"
    inputBinding:
      position: 100
      prefix: -z
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
    doc: "keep plotting data as .cni, .asmi, and .hpi files for a later go"
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
  - id: stats
    type: File[]
    doc: "Completeness, QV and phase-block statistics"
    outputBinding:
      glob: $(inputs.out_prefix).*.stats
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
      glob: [$(inputs.out_prefix)*.cni, $(inputs.out_prefix)*.asmi, $(inputs.out_prefix)*.hpi]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
