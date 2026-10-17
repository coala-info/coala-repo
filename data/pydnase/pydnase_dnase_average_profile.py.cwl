cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_average_profile.py
label: pydnase_dnase_average_profile.py
doc: "Plots average profile of DNase (or Tn5 for ATAC-seq) activity surrounding a list of regions in a BED file.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions you want to generate the average profile for"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The BAM file containing the DNase-seq data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "filename to write the output to"
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
  - id: bias_file
    type:
      - 'null'
      - File
    doc: "Location of the sorted, indexed bias file."
    inputBinding:
      position: 11
      prefix: --bias-file
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: "Ignores any strand information in BED file and plots data relative to reference strand."
    inputBinding:
      position: 12
      prefix: -i
  - id: combine_strands
    type:
      - 'null'
      - boolean
    doc: "Combine the strand information into one graph."
    inputBinding:
      position: 13
      prefix: -c
  - id: normalise_peaks
    type:
      - 'null'
      - boolean
    doc: "Normalise cut counts to a fraction peaks."
    inputBinding:
      position: 14
      prefix: -n
  - id: normalise_bias
    type:
      - 'null'
      - boolean
    doc: "Normalise for cutting bias."
    inputBinding:
      position: 15
      prefix: -b
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: average_profile
    type: File
    doc: "Average profile output."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
