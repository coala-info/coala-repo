cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - radsex
  - map
label: radsex_map
doc: "Aligns markers to a genome and computes metrics for each aligned marker.\n\n\
  Tool homepage: https://github.com/SexGenomicsToolkit/radsex"
inputs:
  - id: markers_table
    type: File
    doc: Path to a set of markers to align, either a depth table from "process", "signif",
      or "subset" or a fasta file from "subset" or "signif"
    inputBinding:
      position: 101
      prefix: --markers-file
  - id: popmap
    type: File
    doc: Path to a tabulated file specifying groups for all individuals (population
      map)
    inputBinding:
      position: 101
      prefix: --popmap
  - id: genome_file
    type: File
    doc: Path to the genome file in fasta format (staged writable because radsex writes the BWA index beside it)
    inputBinding:
      position: 101
      prefix: --genome-file
      valueFrom: $(self.basename)
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a marker present in an individual (default 1)
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: groups
    type:
      - 'null'
      - string
    doc: Names of the groups to compare if there are more than two groups in the popmap
      (group1,group2)
    inputBinding:
      position: 101
      prefix: --groups
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to retain a read (default 20)
    inputBinding:
      position: 101
      prefix: --min-quality
  - id: min_frequency
    type:
      - 'null'
      - float
    doc: Minimum frequency of individuals to retain a marker (default 0.1)
    inputBinding:
      position: 101
      prefix: --min-frequency
  - id: signif_threshold
    type:
      - 'null'
      - float
    doc: P-value threshold to consider a marker significantly associated with a phenotypic
      group (default 0.05)
    inputBinding:
      position: 101
      prefix: --signif-threshold
  - id: disable_correction
    type:
      - 'null'
      - boolean
    doc: If set, Bonferroni correction will NOT be used when assessing significance
      of association with phenotypic group
    inputBinding:
      position: 101
      prefix: --disable-correction
  - id: output_file_path
    type: string
    doc: Path to the output file (mapping position, group bias, and probability of
      association with group for all aligned markers)
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Path to the output file (mapping position, group bias, and probability of
      association with group for all aligned markers)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radsex:1.2.0--h43eeafb_3
