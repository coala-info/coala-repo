cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - gen-ssa
label: sga_gen-ssa
doc: 'Build a sampled suffix array for the reads in READSFILE using the BWT


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: readsfile
    type: File
    doc: Reads file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
    secondaryFiles:
      - ^.bwt
      - ^.rbwt?
  - id: check
    type:
      - 'null'
      - boolean
    doc: validate that the suffix array/bwt is correct
    inputBinding:
      position: 102
      prefix: --check
  - id: sai_only
    type:
      - 'null'
      - boolean
    doc: only build the lexicographic index
    inputBinding:
      position: 102
      prefix: --sai-only
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to construct the index
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: ssa
    type:
      - 'null'
      - File
    doc: Sampled suffix array.
    outputBinding:
      glob: '*.ssa'
  - id: sai
    type:
      - 'null'
      - File
    doc: Lexicographic index (with --sai-only).
    outputBinding:
      glob: '*.sai'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_gen-ssa.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.readsfile)
