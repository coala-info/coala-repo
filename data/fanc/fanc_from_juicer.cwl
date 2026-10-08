cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - from-juicer
label: fanc_from_juicer
doc: "Import a Hi-C object from a Juicer (Aiden lab) .hic file. Needs juicer_tools.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input .hic file, juicer format."
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: "Genome FASTA (or FAN-C hdf5 genome)."
    inputBinding:
      position: 2
  - id: resolution
    type: int
    doc: "Resolution in base pairs."
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "Output FAN-C Hic file."
    inputBinding:
      position: 4
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of chromosomes to extract. Extracts all chromosomes in genome by default."
    inputBinding:
      position: 20
      prefix: --chromosomes
  - id: no_inter_chromosomal
    type:
      - 'null'
      - boolean
    doc: "Do not extract inter-chromosomal matrices"
    inputBinding:
      position: 20
      prefix: --no-inter-chromosomal
  - id: juicer_norm
    type:
      - 'null'
      - string
    doc: "Juicer normalisation method. Default: NONE, see juicer documentation for alternatives."
    inputBinding:
      position: 20
      prefix: --juicer-norm
  - id: juicer_tools_jar
    type:
      - 'null'
      - File
    doc: "Path to juicer jar. You can also specify this in fanc.conf"
    inputBinding:
      position: 20
      prefix: --juicer-tools-jar
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: hic
    type: File
    doc: "FAN-C Hic object."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
