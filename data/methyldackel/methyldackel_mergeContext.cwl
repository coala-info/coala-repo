cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylDackel
  - mergeContext
label: methyldackel_mergeContext
doc: "Merge single Cytosine methylation metrics into per-CpG/CHG metrics.\n\nTool homepage: https://github.com/dpryan79/MethylDackel"
inputs:
  - id: ref
    type: File
    secondaryFiles:
      - .fai
    doc: "Reference genome in fasta format, indexed with samtools faidx."
    inputBinding:
      position: 100
  - id: input_file
    type: File
    doc: "An input file such as that produced by MethylDackel extract, coordinate sorted."
    inputBinding:
      position: 101
  - id: output_file
    type: string
    doc: "Output file name"
    inputBinding:
      position: 50
      prefix: -o
outputs:
  - id: merged
    type: File
    doc: "Per-CpG/CHG methylation metrics."
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
