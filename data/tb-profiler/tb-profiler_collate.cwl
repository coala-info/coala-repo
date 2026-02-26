cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler_collate
label: tb-profiler_collate
doc: "Collate results from TBProfiler runs.\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: Path to the barcode BED file.
    inputBinding:
      position: 101
      prefix: --barcode_file
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Path to the genes BED file.
    inputBinding:
      position: 101
      prefix: --bed_file
  - id: bedmask_file
    type:
      - 'null'
      - File
    doc: Path to the mask BED file.
    inputBinding:
      position: 101
      prefix: --bedmask_file
  - id: gff_file
    type:
      - 'null'
      - File
    doc: Path to the GFF file.
    inputBinding:
      position: 101
      prefix: --gff_file
  - id: json_db
    type:
      - 'null'
      - File
    doc: Path to the mutations JSON database file.
    inputBinding:
      position: 101
      prefix: --json_db
  - id: ref_file
    type:
      - 'null'
      - File
    doc: Path to the reference genome FASTA file.
    inputBinding:
      position: 101
      prefix: --ref_file
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the TBProfiler results to collate.
    inputBinding:
      position: 101
      prefix: --results_dir
  - id: rules_file
    type:
      - 'null'
      - File
    doc: Path to the rules YAML file.
    inputBinding:
      position: 101
      prefix: --rules_file
  - id: snpEff_config
    type:
      - 'null'
      - File
    doc: Path to the snpEff_config file.
    inputBinding:
      position: 101
      prefix: --snpEff_config
  - id: spoligotype_annotations
    type:
      - 'null'
      - File
    doc: Path to the spoligotype_annotations CSV file.
    inputBinding:
      position: 101
      prefix: --spoligotype_annotations
  - id: spoligotype_spacers
    type:
      - 'null'
      - File
    doc: Path to the spoligotype_spacers file.
    inputBinding:
      position: 101
      prefix: --spoligotype_spacers
  - id: variables_file
    type:
      - 'null'
      - File
    doc: Path to the variables JSON file.
    inputBinding:
      position: 101
      prefix: --variables_file
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the collated results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
