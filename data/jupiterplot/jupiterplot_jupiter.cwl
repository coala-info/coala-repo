cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupiter
label: jupiterplot_jupiter
doc: "Jupiter Plot: draws a Circos plot of the alignment of a scaffold or contig assembly to a reference genome.\n\nTool homepage: https://github.com/JustinChu/JupiterPlot"
inputs:
  - id: name
    type: string
    doc: Output file prefix
    inputBinding:
      position: 1
      prefix: name=
      separate: false
  - id: ref
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 2
      prefix: ref=
      separate: false
  - id: fa
    type: File
    doc: FASTA file of the contigs or scaffolds to compare with the reference
    inputBinding:
      position: 3
      prefix: fa=
      separate: false
  - id: sam
    type: ['null', File]
    doc: Use this SAM alignment instead of running minimap2
    inputBinding:
      position: 4
      prefix: sam=
      separate: false
  - id: t
    type: ['null', int]
    doc: Number of threads to use for minimap2 (default 4)
    inputBinding:
      position: 5
      prefix: t=
      separate: false
  - id: m
    type: ['null', int]
    doc: Only use reference chromosomes larger than this value (default 100000)
    inputBinding:
      position: 6
      prefix: m=
      separate: false
  - id: ng
    type: ['null', int]
    doc: Use the largest scaffolds that cover this percent of the genome; 0 uses all scaffolds (default 75)
    inputBinding:
      position: 7
      prefix: ng=
      separate: false
  - id: max_scaff
    type: ['null', int]
    doc: Instead of ng, filter by this number of scaffolds (default -1)
    inputBinding:
      position: 8
      prefix: maxScaff=
      separate: false
  - id: i
    type: ['null', int]
    doc: Increment for colouring chromosomes, HSV colour shift 0-360; above 360 gives random colours (default 0)
    inputBinding:
      position: 9
      prefix: i=
      separate: false
  - id: g
    type: ['null', int]
    doc: Minimum gap size in the reference to render (default 1)
    inputBinding:
      position: 10
      prefix: g=
      separate: false
  - id: g_scaff
    type: ['null', int]
    doc: Minimum gap size in scaffolds to render (default 100000)
    inputBinding:
      position: 11
      prefix: gScaff=
      separate: false
  - id: labels
    type: ['null', string]
    doc: Show reference chromosome names (ref), scaffold names (scaf) or both (default ref)
    inputBinding:
      position: 12
      prefix: labels=
      separate: false
  - id: max_gap
    type: ['null', int]
    doc: Maximum alignment gap allowed to consider a region contiguous (default 100000)
    inputBinding:
      position: 13
      prefix: maxGap=
      separate: false
  - id: min_bundle_size
    type: ['null', int]
    doc: Minimum size of a contiguous region to render (default 50000)
    inputBinding:
      position: 14
      prefix: minBundleSize=
      separate: false
  - id: mapq
    type: ['null', int]
    doc: Maximum mapping quality allowed when filtering (default 50)
    inputBinding:
      position: 15
      prefix: MAPQ=
      separate: false
  - id: link_alpha
    type: ['null', int]
    doc: Alpha of links, 1 = 17%, 2 = 33%, 3 = 50%, 4 = 67%, 5 = 83% (default 5)
    inputBinding:
      position: 16
      prefix: linkAlpha=
      separate: false
  - id: profile
    type: ['null', boolean]
    doc: Print the run time of each step
    inputBinding:
      position: 20
      prefix: profile=1
outputs:
  - id: svg
    type: File
    doc: Circos plot of the alignment (SVG)
    outputBinding:
      glob: $(inputs.name).svg
  - id: png
    type: ['null', File]
    doc: Circos plot of the alignment (PNG), when written
    outputBinding:
      glob: $(inputs.name).png
  - id: conf
    type: ['null', File]
    doc: Circos configuration file
    outputBinding:
      glob: $(inputs.name).conf
  - id: karyotype
    type: ['null', File]
    doc: Circos karyotype file
    outputBinding:
      glob: $(inputs.name).karyotype
  - id: links_final
    type: ['null', File]
    doc: Bundled alignment links used for the plot
    outputBinding:
      glob: $(inputs.name).links.final
  - id: agp
    type: ['null', File]
    doc: AGP file describing the scaffolds
    outputBinding:
      glob: $(inputs.name).agp
  - id: seq_order
    type: ['null', File]
    doc: Order of the scaffolds in the plot
    outputBinding:
      glob: $(inputs.name).seqOrder.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jupiterplot:1.1--hdfd78af_0
stdout: jupiterplot_jupiter.out
