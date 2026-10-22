cwlVersion: v1.2
class: CommandLineTool
baseCommand: [screed, dump_fastq]
label: screed_dump_fastq
doc: "Convert a screed database to a FASTQ file\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs:
  - id: dbfile
    type: File
    doc: The screed database to convert (made by screed db).
    inputBinding:
      position: 1
  - id: outputfile
    type: string
    doc: Name of the FASTQ file to write.
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: The FASTQ file
    outputBinding:
      glob: $(inputs.outputfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
