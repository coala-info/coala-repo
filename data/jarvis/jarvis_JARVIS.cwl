cwlVersion: v1.2
class: CommandLineTool
baseCommand: JARVIS
label: jarvis_JARVIS
doc: "extreme lossless compression of genomic sequences.\n\nTool homepage: https://github.com/cobilab/jarvis"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
        writable: true
  - class: InlineJavascriptRequirement
inputs:
  - id: file
    type: File
    doc: Input sequence filename (to compress, or the .jc file to decompress) -- MANDATORY.
      The file is the last argument.
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Run decompression (the input is a .jc file).
    inputBinding:
      position: 102
      prefix: -d
  - id: context_model
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -cm
    doc: Template of a context model, [NB_C]:[NB_D]:[NB_I]:[NB_G]/[NB_S]:[NB_E]:[NB_I]:[NB_A].
      Can be given several times.
    inputBinding:
      position: 102
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: it creates a file with the extension ".iae" with the respective 
      information content. If the file is FASTA or FASTQ it will only use the 
      "ACGT" (genomic) sequence.
    inputBinding:
      position: 102
      prefix: --estimate
  - id: estimation
    type:
      - 'null'
      - boolean
    doc: creates [sequence].info with complexity profile.
    inputBinding:
      position: 102
      prefix: --estimation
  - id: force
    type:
      - 'null'
      - boolean
    doc: force mode. Overwrites old files.
    inputBinding:
      position: 102
      prefix: --force
  - id: level
    type:
      - 'null'
      - int
    doc: Compression level (integer).
    inputBinding:
      position: 102
      prefix: --level
  - id: repeat_model
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -rm
    doc: Template of a repeat model, [NB_R]:[NB_C]:[NB_A]:[NB_B]:[NB_L]:[NB_G]:[NB_I].
      Can be given several times.
    inputBinding:
      position: 102
  - id: selection
    type:
      - 'null'
      - int
    doc: Size of the context selection model (integer).
    inputBinding:
      position: 102
      prefix: --selection
  - id: show_levels
    type:
      - 'null'
      - boolean
    doc: show pre-computed compression levels (configured).
    inputBinding:
      position: 102
      prefix: --show-levels
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: compressed
    type:
      - 'null'
      - File
    doc: Compressed file (.jc)
    outputBinding:
      glob: $(inputs.file.basename).jc
  - id: decompressed
    type:
      - 'null'
      - File
    doc: Decompressed sequence (the .jd file written when decompressing)
    outputBinding:
      glob: $(inputs.file.basename).jd
  - id: info
    type:
      - 'null'
      - File
    doc: Complexity profile (--estimation)
    outputBinding:
      glob: $(inputs.file.basename).info
  - id: iae
    type:
      - 'null'
      - File
    doc: Information content (--estimate)
    outputBinding:
      glob: $(inputs.file.basename).iae
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jarvis:1.1--h7b50bb2_6
stdout: jarvis_JARVIS.out
