cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbmerge
label: pbtk_pbmerge
doc: "pbmerge merges PacBio BAM files. If the input is DataSetXML, any filters will
  be applied.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: 'Input file(s). Maybe one of: DataSetXML, BAM file(s), or FOFN'
    inputBinding:
      position: 1
  - id: no_pbi
    type:
      - 'null'
      - boolean
    doc: Disables creation of PBI index file. PBI always disabled when writing to
      stdout.
    inputBinding:
      position: 102
      prefix: --no-pbi
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM filename. Writes to stdout if not provided.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
