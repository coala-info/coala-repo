cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShortTracks
label: shorttracks_ShortTracks
doc: "Calculate and plot coverage tracks from BAM files.\n\nTool homepage: https://github.com/MikeAxtell/ShortTracks"
inputs:
  - id: bamfile
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .csi
        required: false
    doc: Path to bamfile. The corresponding .bai or .csi file must also be 
      there.
    inputBinding:
      position: 101
      prefix: --bamfile
      valueFrom: $(self.basename)
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Parsing mode: simple, readgroup, or readlength'
    inputBinding:
      position: 101
      prefix: --mode
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: If set, stranded splits + and - coverage intoseparate tracks
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tracks
    type: File[]
    doc: Coverage track files written beside the BAM file (wiggle, bigWig, bedGraph and depth files)
    outputBinding:
      glob: ["*.wig", "*.bw", "*.bigwig", "*.bedgraph", "*.bg", "*_depths.txt"]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bamfile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorttracks:1.3--hdfd78af_0
stdout: shorttracks_ShortTracks.out
