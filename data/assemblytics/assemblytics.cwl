cwlVersion: v1.2
class: CommandLineTool
baseCommand: Assemblytics
label: assemblytics
doc: "Assemblytics is a tool for detecting and analyzing structural variants from
  a genome assembly compared to a reference genome. It takes a MUMmer .delta file
  as input.\n\nTool homepage: http://assemblytics.com/"
inputs:
  - id: delta_file
    type: File
    doc: MUMmer .delta file from aligning a query assembly to a reference genome
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for all output files (a folder of the same name also holds progress.log)
    inputBinding:
      position: 2
  - id: unique_anchor_length
    type: int
    doc: Minimum unique anchor length (e.g., 10000)
    inputBinding:
      position: 3
  - id: min_variant_size
    type: int
    doc: Minimum variant size to report (e.g., 50)
    inputBinding:
      position: 4
  - id: max_variant_size
    type: int
    doc: Maximum variant size to report (e.g., 100000)
    inputBinding:
      position: 5
outputs:
  - id: structural_variants
    type: File
    doc: Structural variants in BED format
    outputBinding:
      glob: $(inputs.output_prefix).Assemblytics_structural_variants.bed
  - id: output_files
    type:
      type: array
      items: File
    doc: All files written with the output prefix (stats, summaries, plots, coords)
    outputBinding:
      glob: $(inputs.output_prefix).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblytics:1.2.1--0
