cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - bed
label: leviosam2_bed
doc: "Lift over a BED file\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs:
  - id: bed_fname
    type: File
    doc: Path to the input BED.
    inputBinding:
      position: 101
      prefix: --bed_fname
  - id: chainmap
    type: File
    doc: Path to an indexed ChainMap. See `leviosam2 index` for details.
    inputBinding:
      position: 101
      prefix: --chainmap
  - id: gaps
    type:
      - 'null'
      - int
    doc: Number of allowed gaps for an interval.
    inputBinding:
      position: 101
      prefix: -G
  - id: prefix
    type: string
    doc: Prefix to the output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level
    inputBinding:
      position: 101
      prefix: --verbose_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
stdout: leviosam2_bed.out
