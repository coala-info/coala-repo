cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_to_javatreeview.py
label: pydnase_dnase_to_javatreeview.py
doc: "Writes a JavaTreeView file based on the regions in reads BED file and the reads in reads BAM file.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions you want to generate the heatmap for"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The BAM file containing the read data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "filename to write the CSV output to"
    inputBinding:
      position: 3
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Size of flanking area around centre of the regions to plot (default: 100)."
    inputBinding:
      position: 10
      prefix: --window_size
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: "Ignores strand information in BED file."
    inputBinding:
      position: 11
      prefix: -i
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: "Orders output the same as the input (default: orders by FOS)."
    inputBinding:
      position: 12
      prefix: -o
  - id: absolute_counts
    type:
      - 'null'
      - boolean
    doc: "Write absolute cut counts instead strand imbalanced counts."
    inputBinding:
      position: 13
      prefix: -a
  - id: normalise
    type:
      - 'null'
      - boolean
    doc: "Normalise the cut data for each region between 0 and 1."
    inputBinding:
      position: 14
      prefix: -n
  - id: low_ram
    type:
      - 'null'
      - boolean
    doc: "Disable memory caching (low RAM mode)."
    inputBinding:
      position: 15
      prefix: -c
  - id: normalise_bias
    type:
      - 'null'
      - boolean
    doc: "Normalise for cutting bias."
    inputBinding:
      position: 16
      prefix: -b
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
  - id: bias_file
    type:
      - 'null'
      - File
    doc: "Location of the sorted, indexed bias file."
    inputBinding:
      position: 21
      prefix: --bias-file
  - id: randomise
    type:
      - 'null'
      - boolean
    doc: "Randomise the ordering of the output."
    inputBinding:
      position: 22
      prefix: -r
outputs:
  - id: heatmap_csv
    type: File
    doc: "JavaTreeView CSV file."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
