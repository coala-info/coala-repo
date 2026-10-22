cwlVersion: v1.2
class: CommandLineTool
baseCommand: sublong
label: subread_sublong
doc: "Align long reads (Nanopore and PacBio) with the Sublong aligner.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: index_basename
    type: string
    doc: Base name of the index.
    inputBinding:
      position: 1
      prefix: -i
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files built by subread-buildindex (staged in the working directory so the base name resolves)
  - id: reads
    type: File
    doc: Name of an input read file (FASTQ or gzipped FASTQ).
    inputBinding:
      position: 1
      prefix: -r
  - id: output_file
    type: string
    doc: Name of an output file in BAM format.
    inputBinding:
      position: 1
      prefix: -o
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: Save mapping results in SAM format.
    inputBinding:
      position: 1
      prefix: --SAMoutput
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads used. 1 by default.
    inputBinding:
      position: 1
      prefix: -T
  - id: rna_mode
    type:
      - 'null'
      - boolean
    doc: Turn on the RNA-seq mode.
    inputBinding:
      position: 1
      prefix: -X
outputs:
  - id: alignment
    type: File
    doc: Mapping results
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
