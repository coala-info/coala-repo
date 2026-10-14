cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylocsf++
  - annotate-with-tracks
label: phylocsfpp_annotate-with-tracks
doc: "Computes PhyloCSF scores for CDS features in GFF/GTF files and outputs them in the same format. Requires PhyloCSF tracks in BigWig (*.bw) format.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
  - id: output
    type: string
    doc: "Directory where the output GFF/GTF will be written to. If it does not exist, it will be created."
    inputBinding:
      position: 1
      prefix: "--output"
  - id: tracks
    type: File
    doc: "The bigWig file PhyloCSF+1.bw (the other 5 frames, and optionally the power track, are expected in the same directory: list them in track_files)."
    inputBinding:
      position: 2
  - id: track_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The other bigWig tracks (PhyloCSF+2.bw, PhyloCSF+3.bw, PhyloCSF-1.bw, PhyloCSF-2.bw, PhyloCSF-3.bw and optionally PhyloCSFpower.bw), staged next to the first track"
  - id: gff_files
    type:
      type: array
      items: File
    doc: "One or more GFF/GTF files with coding exons to be scored."
    inputBinding:
      position: 3
outputs:
  - id: annotated
    type:
      - 'null'
      - Directory
    doc: "Annotated GFF/GTF files"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.tracks)
      - $(inputs.track_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp_annotate-with-tracks.out
