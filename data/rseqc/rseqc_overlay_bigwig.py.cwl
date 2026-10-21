cwlVersion: v1.2
class: CommandLineTool
baseCommand: [overlay_bigwig.py]
label: rseqc_overlay_bigwig.py
doc: "Combine two BigWig files signal by signal (add, average, divide, max, min, product, subtract or geometric mean) and write a wig file.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: bwfile1
    type: File
    doc: "One BigWig file."
    inputBinding:
      position: 1
      prefix: --bwfile1
  - id: bwfile2
    type: File
    doc: "Another BigWig file. Both BigWig files should use the same reference genome."
    inputBinding:
      position: 1
      prefix: --bwfile2
  - id: action
    type: string
    doc: "After pairwise align two bigwig files, perform the follow actions (Only select one keyword): \"Add\" = add signals. \"Average\" = average signals. \"Division\" = divide bigwig2 from bigwig1. Add 1 to both bigwig. \"Max\" = pick the signal that is larger. \"Min\" = pick the signal that is smaller. \"Product\" = multiply signals. \"Subtract\" = subtract signals in 2nd bigwig file from the corresponiding ones in the 1st bigwig file. \"geometricMean\" = take the geometric mean of signals."
    inputBinding:
      position: 1
      prefix: --action
  - id: output_wig
    type: string
    doc: "Output wig file"
    inputBinding:
      position: 1
      prefix: --output
  - id: chunk
    type:
      - 'null'
      - int
    doc: "Chromosome chunk size. Each chomosome will be cut into samll chunks of this size. Decrease chunk size will save more RAM. default=100000 (bp)"
    inputBinding:
      position: 1
      prefix: --chunk
outputs:
  - id: output_file
    type: File
    doc: "Combined signal in wig format."
    outputBinding:
      glob: "$(inputs.output_wig)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
