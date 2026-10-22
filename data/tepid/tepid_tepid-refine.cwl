cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-refine
label: tepid_tepid-refine
doc: "TEPID -- refine TE insertion and deletion calls using the population-wide
  collapsed variant files.\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs:
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep all intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: insertions
    type:
      - 'null'
      - File
    doc: File containing collapsed TE insertions for all samples in population
    inputBinding:
      position: 101
      prefix: --insertions
  - id: deletions
    type:
      - 'null'
      - File
    doc: File containing collapsed TE deletions for all samples in population
    inputBinding:
      position: 101
      prefix: --deletions
  - id: proc
    type:
      - 'null'
      - int
    doc: number of processors
    inputBinding:
      position: 101
      prefix: --proc
  - id: te
    type: File
    doc: TE annotation bedfile
    inputBinding:
      position: 101
      prefix: --te
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: conc
    type: File
    doc: bam file from bowtie2
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --conc
  - id: split
    type: File
    doc: split reads bam file from yaha
    inputBinding:
      position: 101
      prefix: --split
  - id: all_samples
    type: File
    doc: List of all sample names
    inputBinding:
      position: 101
      prefix: --all_samples
outputs:
  - id: refined_files
    type:
      type: array
      items: File
    doc: refined and ambiguous TE insertion and deletion files for the sample
    outputBinding:
      glob:
        - refined_*$(inputs.sample_name)*
        - ambiguous_*$(inputs.sample_name)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.conc)
        writable: true
      - entry: $(inputs.split)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
