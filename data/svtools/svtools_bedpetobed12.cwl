cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpetobed12
label: svtools_bedpetobed12
doc: 'Convert a BEDPE file to BED12 format for viewing in IGV or the UCSC browser.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_bedpe
    type: File
    doc: BEDPE input file (may be gzipped); if omitted input is read from stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: output_bed12
    type: string
    doc: 'Output BED12 to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
  - id: name
    type:
      - 'null'
      - string
    doc: The name of the track. Default is 'BEDPE'
    inputBinding:
      position: 101
      prefix: --name
  - id: maxdist
    type:
      - 'null'
      - int
    doc: The minimum distance for drawing intrachromosomal features as if they are
      interchromosomal (i.e., without a line spanning the two footprints). Default
      is 1Mb.
    inputBinding:
      position: 101
      prefix: --maxdist
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_bed12
    type: File
    doc: Output BED12
    outputBinding:
      glob: $(inputs.output_bed12)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
