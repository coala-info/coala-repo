cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - correct
label: flair_correct
doc: "take bed file of long RNA-seq reads and filter out those with anomalous splice
  junctions correct remaining to nearest orthogonally supported splice site\n\nTool
  homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF annotation file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: junction_bed
    type:
      - 'null'
      - File
    doc: short-read junctions in bed format (can be generated from short-read alignment
      with junctions_from_sam)
    inputBinding:
      position: 101
      prefix: --junction_bed
  - id: junction_support
    type:
      - 'null'
      - int
    doc: if providing short-read junctions, minimum junction support required to keep
      junction. If your junctions file is in bed format, the score field will be used
      for read support.
    inputBinding:
      position: 101
      prefix: --junction_support
  - id: junction_tab
    type:
      - 'null'
      - File
    doc: short-read junctions in SJ.out.tab format. Use this option if you aligned
      your short-reads with STAR, STAR will automatically output this file
    inputBinding:
      position: 101
      prefix: --junction_tab
  - id: nvrna
    type:
      - 'null'
      - boolean
    doc: specify this flag to make the strand of a read consistent with the annotation
      during correction
    inputBinding:
      position: 101
      prefix: --nvrna
  - id: query
    type: File
    doc: uncorrected bed12 file
    inputBinding:
      position: 101
      prefix: --query
  - id: ss_window
    type:
      - 'null'
      - int
    doc: window size for correcting splice sites
    inputBinding:
      position: 101
      prefix: --ss_window
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output name base
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
