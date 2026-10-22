cwlVersion: v1.2
class: CommandLineTool
baseCommand: strucVis
label: strucvis_strucVis
doc: "strucVis draws the predicted secondary structure (RNAfold) of a genomic locus with the coverage of aligned small RNA reads on it.\n\nTool homepage: https://github.com/MikeAxtell/strucVis"
inputs:
  - id: bam_file
    type: File
    doc: PATH to sorted and indexed file of aligned small RNA reads
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 1
      prefix: -b
  - id: genome
    type: File
    doc: PATH to genome in FASTA format (indexed with samtools faidx)
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 2
      prefix: -g
  - id: coordinates
    type: string
    doc: Coordinates of interest in format Chr:Start-Stop, one-based, inclusive
    inputBinding:
      position: 3
      prefix: -c
  - id: strand
    type: string
    doc: Genomic strand of interest. Must be 'plus' or 'minus'
    inputBinding:
      position: 4
      prefix: -s
  - id: output_basename
    type: string
    doc: Output pdf file base name (not including the .pdf suffix)
    inputBinding:
      position: 5
      prefix: -p
  - id: locus_name
    type:
      - 'null'
      - string
    doc: Name of the locus. Defaults to 'Unnamed Locus' if not provided
    inputBinding:
      position: 6
      prefix: -n
  - id: suppress_details
    type:
      - 'null'
      - boolean
    doc: Suppress printing of job details on the pdf file
    inputBinding:
      position: 7
      prefix: -x
outputs:
  - id: pdf
    type: File
    doc: Output PDF with the structure and read coverage
    outputBinding:
      glob: $(inputs.output_basename + '.pdf')
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strucvis:0.9--hdfd78af_0
stdout: strucvis_strucVis.out
