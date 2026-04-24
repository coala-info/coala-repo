cwlVersion: v1.2
class: CommandLineTool
baseCommand: flye
label: flye
doc: "De novo assembler for single-molecule sequencing reads using truncated sparse
  strings\n\nTool homepage: https://github.com/fenderglass/Flye/"
inputs:
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Estimated genome size (e.g. 5m or 2.8g)
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of polishing iterations
    inputBinding:
      position: 101
      prefix: --iterations
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Metagenome assembly mode
    inputBinding:
      position: 101
      prefix: --meta
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between reads
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: nano_corr
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT corrected reads
    inputBinding:
      position: 101
      prefix: --nano-corr
  - id: nano_hq
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT high-quality reads (Guppy5+ SUP or Q20)
    inputBinding:
      position: 101
      prefix: --nano-hq
  - id: nano_raw
    type:
      - 'null'
      - type: array
        items: File
    doc: ONT raw reads
    inputBinding:
      position: 101
      prefix: --nano-raw
  - id: pacbio_corr
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio corrected reads
    inputBinding:
      position: 101
      prefix: --pacbio-corr
  - id: pacbio_hifi
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio HiFi reads
    inputBinding:
      position: 101
      prefix: --pacbio-hifi
  - id: pacbio_raw
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio raw reads
    inputBinding:
      position: 101
      prefix: --pacbio-raw
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume from the last completed stage
    inputBinding:
      position: 101
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flye:2.9.6--py310h275bdba_0
