cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapemapper
label: shapemapper
doc: "ShapeMapper automates the extraction of SHAPE reactivity profiles from chemical
  probing multi-stage sequencing experiments.\n\nTool homepage: https://github.com/Weeks-UNC/shapemapper2"
inputs:
  - id: denatured
    type:
      - 'null'
      - type: array
        items: File
    doc: Denatured control sample FASTQ files or directory.
    inputBinding:
      position: 101
      prefix: --denatured
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum sequencing depth required to calculate reactivity.
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: modified
    type:
      type: array
      items: File
    doc: Modified (treated) sample FASTQ files or directory.
    inputBinding:
      position: 101
      prefix: --modified
  - id: name
    type:
      - 'null'
      - string
    doc: Experiment name used for labeling output files.
    inputBinding:
      position: 101
      prefix: --name
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors to use for alignment and analysis.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files in the output directory.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: target
    type: File
    doc: Target FASTA file containing one or more sequences.
    inputBinding:
      position: 101
      prefix: --target
  - id: untreated
    type:
      type: array
      items: File
    doc: Untreated (control) sample FASTQ files or directory.
    inputBinding:
      position: 101
      prefix: --untreated
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory for reactivity profiles and logs.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:1.2--py27_0
