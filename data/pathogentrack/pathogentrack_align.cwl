cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - align
label: pathogentrack_align
doc: "align clean reads to the reference genome\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: star_index
    type: Directory
    doc: star indices of the reference genome
    inputBinding:
      position: 101
      prefix: --star_index
  - id: input_reads
    type:
      - 'null'
      - File
    doc: input single-end fastq file (it is placed in the project folder)
    inputBinding:
      position: 101
      prefix: --input_reads
      valueFrom: "$(self ? self.basename : null)"
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads to use, default is 8
    inputBinding:
      position: 101
      prefix: --thread
  - id: output
    type:
      - 'null'
      - string
    doc: file to output unmapped reads to
    default: unmapped_reads.fq
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: unmapped_reads
    type: File
    doc: reads that did not map to the reference genome
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_id)
        writable: true
        entry: "$({\"class\": \"Directory\", \"basename\": inputs.project_id, \"listing\": [inputs.input_reads]})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
