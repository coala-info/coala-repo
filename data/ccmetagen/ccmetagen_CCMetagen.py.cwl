cwlVersion: v1.2
class: CommandLineTool
baseCommand: CCMetagen.py
label: ccmetagen_CCMetagen.py
doc: "CCMetagen is a pipeline for accurate taxonomic classification and abundance
  estimation of metagenomic data, typically using KMA (K-mer Alignment) results.\n\
  \ \nTool homepage: https://github.com/vrmarcelino/CCMetagen"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: "What CCMetagen should output: 'visual', 'text' or 'both' (default: both)"
    inputBinding:
      position: 101
      prefix: --mode
  - id: res_fp
    type: File
    doc: Path to the KMA result (.res file)
    inputBinding:
      position: 101
      prefix: --res_fp
  - id: output_fp
    type:
      - 'null'
      - string
    default: CCMetagen_out
    doc: 'Path (prefix) of the output files (default: CCMetagen_out)'
    inputBinding:
      position: 101
      prefix: --output_fp
  - id: reference_database
    type:
      - 'null'
      - string
    doc: "Which reference database was used. Options: UNITE, RefSeq or nt (default:
      nt)"
    inputBinding:
      position: 101
      prefix: --reference_database
  - id: extended_output_file
    type:
      - 'null'
      - string
    doc: "Produce an extended output file that includes the percentage of classified
      reads. Options: y or n. Needs --mapstat (default: n)"
    inputBinding:
      position: 101
      prefix: --extended_output_file
  - id: depth_unit
    type:
      - 'null'
      - string
    doc: "Unit for depth (abundance): 'kma', 'nc', 'rpm' or 'fr' (default: kma)"
    inputBinding:
      position: 101
      prefix: --depth_unit
  - id: mapstat
    type:
      - 'null'
      - File
    doc: Path to the mapstat file produced with KMA when using the -ef flag (.mapstat)
    inputBinding:
      position: 101
      prefix: --mapstat
  - id: depth
    type:
      - 'null'
      - float
    doc: 'Minimum sequencing depth, in the unit set by --depth_unit (default: 0.2)'
    inputBinding:
      position: 101
      prefix: --depth
  - id: coverage
    type:
      - 'null'
      - float
    doc: 'Percentage of minimum coverage of the reference sequence (default: 20)'
    inputBinding:
      position: 101
      prefix: --coverage
  - id: query_identity
    type:
      - 'null'
      - float
    doc: 'Minimum query identity (Phylum level) (default: 50)'
    inputBinding:
      position: 101
      prefix: --query_identity
  - id: pvalue
    type:
      - 'null'
      - float
    doc: 'Minimum p-value (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: krona_mode
    type:
      - 'null'
      - string
    doc: "Abundance measure for the Krona graph: 'Depth', 'rc' or 'rca' (default:
      Depth)"
    inputBinding:
      position: 101
      prefix: --krona_mode
  - id: local_taxfile
    type:
      - 'null'
      - File
    doc: Local ete3 NCBI taxonomy database file (taxa.sqlite). CCMetagen 1.5.0 only
      checks this option and reads lineages from $HOME/.etetoolkit/taxa.sqlite, so
      the file is also staged there.
    inputBinding:
      position: 101
      prefix: --local_taxfile
  - id: species_threshold
    type:
      - 'null'
      - float
    doc: 'Species-level similarity threshold (default: 98.41)'
    inputBinding:
      position: 101
      prefix: --species_threshold
  - id: genus_threshold
    type:
      - 'null'
      - float
    doc: 'Genus-level similarity threshold (default: 96.31)'
    inputBinding:
      position: 101
      prefix: --genus_threshold
  - id: family_threshold
    type:
      - 'null'
      - float
    doc: 'Family-level similarity threshold (default: 88.51)'
    inputBinding:
      position: 101
      prefix: --family_threshold
  - id: order_threshold
    type:
      - 'null'
      - float
    doc: 'Order-level similarity threshold (default: 81.21)'
    inputBinding:
      position: 101
      prefix: --order_threshold
  - id: class_threshold
    type:
      - 'null'
      - float
    doc: 'Class-level similarity threshold (default: 80.91)'
    inputBinding:
      position: 101
      prefix: --class_threshold
  - id: phylum_threshold
    type:
      - 'null'
      - float
    doc: 'Phylum-level similarity threshold; 0 means not applied (default: 0)'
    inputBinding:
      position: 101
      prefix: --phylum_threshold
  - id: turn_off_sim_thresholds
    type:
      - 'null'
      - string
    doc: "Turns similarity-based filtering off. Options: 'y' or 'n' (default: n)"
    inputBinding:
      position: 101
      prefix: --turn_off_sim_thresholds
outputs:
  - id: ccm_csv
    type:
      - 'null'
      - File
    doc: Text table with taxonomic information and mapping details (text/both modes)
    outputBinding:
      glob: $(inputs.output_fp).ccm.csv
  - id: krona_tsv
    type:
      - 'null'
      - File
    doc: Simplified table used for the Krona graph (visual/both modes)
    outputBinding:
      glob: $(inputs.output_fp).tsv
  - id: krona_html
    type:
      - 'null'
      - File
    doc: Krona HTML graph (visual/both modes)
    outputBinding:
      glob: $(inputs.output_fp).html
  - id: stats_csv
    type:
      - 'null'
      - File
    doc: Extended output with the percentage of classified reads
    outputBinding:
      glob: $(inputs.output_fp)_stats.csv
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ if (inputs.local_taxfile) { return [{'entry': inputs.local_taxfile, 'entryname':
        '.etetoolkit/taxa.sqlite'}]; } return []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0
