cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_bias_estimator.py
label: pydnase_dnase_bias_estimator.py
doc: "Calculates the 6-mer 5' insertion bias for a NGS dataset.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions you want to exclude from calculating the bias. This is usually the DHSs."
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The sorted, indexed BAM file containing the DNase-seq data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: genome_sequence
    type: File
    doc: "The sorted, indexed FASTA file containing the genome sequence."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 3
  - id: genome_size
    type: File
    doc: "The .chrom.sizes file containing chromosome sizes."
    inputBinding:
      position: 4
  - id: output
    type: string
    doc: "output file prefix to write the observed/expected ratios to (will append .txt and .pickle)."
    inputBinding:
      position: 5
outputs:
  - id: bias_txt
    type: File
    doc: "Observed/expected 6-mer bias ratios."
    outputBinding:
      glob: $(inputs.output).txt
  - id: bias_pickle
    type: File
    doc: "Bias estimates as pickle."
    outputBinding:
      glob: $(inputs.output).pickle
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
