cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt-split
label: crossfilt_crossfilt-split
doc: "Splits a bam file into equal sized chunks, keeping paired reads together. This
  may return fewer files than expected if many reads are missing a pair.\n\nTool homepage:
  https://github.com/kennethabarr/CrossFilt"
inputs:
  - id: file_size
    type:
      - 'null'
      - int
    doc: The number of reads per file
    inputBinding:
      position: 101
      prefix: --file-size
  - id: input
    type: File
    doc: The input BAM file to split
    inputBinding:
      position: 101
      prefix: --input
  - id: ncpu
    type:
      - 'null'
      - int
    doc: The number of CPU cores to use
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: nfiles
    type:
      - 'null'
      - int
    doc: The number of files to split this into
    inputBinding:
      position: 101
      prefix: --nfiles
  - id: output
    type: string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --output
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Add this flag if the reads are paired
    inputBinding:
      position: 101
      prefix: --paired
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-split.out
