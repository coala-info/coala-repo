cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem appraise
label: singlem_appraise
doc: "How much of the metagenome do the genomes or assembly represent?\n\nTool homepage:
  https://github.com/wwood/singlem"
inputs:
  - id: assembly_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: archive output of 'pipe' run on assembled sequence
    inputBinding:
      position: 101
      prefix: --assembly-archive-otu-tables
  - id: assembly_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: output of 'pipe' run on assembled sequence
    inputBinding:
      position: 101
      prefix: --assembly-otu-tables
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: genome_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: archive output of 'pipe' run on genomes
    inputBinding:
      position: 101
      prefix: --genome-archive-otu-tables
  - id: genome_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: output of 'pipe' run on genomes
    inputBinding:
      position: 101
      prefix: --genome-otu-tables
  - id: imperfect
    type:
      - 'null'
      - boolean
    doc: "use sequence searching to account for genomes that are\nsimilar to those
      found in the metagenome"
    inputBinding:
      position: 101
      prefix: --imperfect
  - id: metagenome_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: archive output of 'pipe' run on metagenomes
    inputBinding:
      position: 101
      prefix: --metagenome-archive-otu-tables
  - id: metagenome_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: output of 'pipe' run on metagenomes
    inputBinding:
      position: 101
      prefix: --metagenome-otu-tables
  - id: metapackage
    type:
      - 'null'
      - string
    doc: Metapackage used in the creation of the OTU tables
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: output_found_in
    type:
      - 'null'
      - boolean
    doc: "Output sample name (genome or assembly) the hit was\nfound in"
    inputBinding:
      position: 101
      prefix: --output-found-in
  - id: output_style
    type:
      - 'null'
      - string
    doc: Style of output OTU tables
    inputBinding:
      position: 101
      prefix: --output-style
  - id: plot
    type:
      - 'null'
      - File
    doc: "Output plot SVG filename (marker chosen automatically\nunless --plot-marker
      is also specified)"
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_basename
    type:
      - 'null'
      - string
    doc: "Plot visualisation of appraisal results from all\nmarkers to this basename
      (one SVG per marker)"
    inputBinding:
      position: 101
      prefix: --plot-basename
  - id: plot_marker
    type:
      - 'null'
      - string
    doc: Marker gene to plot OTUs from
    inputBinding:
      position: 101
      prefix: --plot-marker
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequence_identity
    type:
      - 'null'
      - float
    doc: "sequence identity cutoff to use if --imperfect is\nspecified"
    inputBinding:
      position: 101
      prefix: --sequence-identity
  - id: stream_inputs
    type:
      - 'null'
      - boolean
    doc: "Stream input OTU tables, saving RAM. Only works with\n--output-otu-table
      and transformation options do not\nwork [expert option]."
    inputBinding:
      position: 101
      prefix: --stream-inputs
  - id: threads
    type:
      - 'null'
      - int
    doc: Use this many threads when processing streaming inputs
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_binned_otu_table
    type:
      - 'null'
      - File
    doc: output OTU table of binned populations
    outputBinding:
      glob: $(inputs.output_binned_otu_table)
  - id: output_unbinned_otu_table
    type:
      - 'null'
      - File
    doc: "output OTU table of assembled but not binned\npopulations"
    outputBinding:
      glob: $(inputs.output_unbinned_otu_table)
  - id: output_assembled_otu_table
    type:
      - 'null'
      - File
    doc: output OTU table of all assembled populations
    outputBinding:
      glob: $(inputs.output_assembled_otu_table)
  - id: output_unaccounted_for_otu_table
    type:
      - 'null'
      - File
    doc: Output OTU table of populations not accounted for
    outputBinding:
      glob: $(inputs.output_unaccounted_for_otu_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
