cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - juicer
  - pre
label: yahs_juicer_pre
doc: "Generate files compatible with the Juicebox toolset\n\nTool homepage: https://github.com/c-zhou/yahs"
inputs:
  - id: assembly_mode
    type:
      - 'null'
      - boolean
    doc: preprocess for assembly mode
    inputBinding:
      position: 1
      prefix: -a
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality [10]
    inputBinding:
      position: 2
      prefix: -q
  - id: output_prefix
    type: string
    doc: output file prefix (required for '-a' mode)
    inputBinding:
      position: 3
      prefix: -o
  - id: file_type
    type:
      - 'null'
      - string
    doc: input file type BED|BAM|PA5|BIN, file name extension is ignored if set
    inputBinding:
      position: 4
      prefix: --file-type
  - id: hic_data
    type: File
    doc: Hi-C alignments (BED, BAM, PA5 or BIN)
    inputBinding:
      position: 5
  - id: scaffolds_agp
    type: File
    doc: scaffolds AGP file
    inputBinding:
      position: 6
  - id: contigs_fai
    type: File
    doc: contigs FASTA index (.fai)
    inputBinding:
      position: 7
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (.txt, and in assembly mode .assembly, .assembly.agp, .liftover.agp)
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
