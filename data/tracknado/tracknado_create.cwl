cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracknado
  - create
label: tracknado_create
doc: "Create a UCSC track hub from a set of files.\n\nTool homepage: https://pypi.org/project/tracknado/"
inputs:
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Required for --convert. Path to a chrom.sizes file for the target 
      genome.
    inputBinding:
      position: 101
      prefix: --chrom-sizes
  - id: color_by
    type:
      - 'null'
      - string
    doc: The metadata column name to use for determining track colors.
    inputBinding:
      position: 101
      prefix: --color-by
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Enable automatic conversion of formats like BED -> bigBed or GTF -> 
      bigGenePred.
    inputBinding:
      position: 101
      prefix: --convert
  - id: custom_genome
    type:
      - 'null'
      - boolean
    doc: Flag to indicate an Assembly Hub (custom genome) rather than a built-in
      UCSC genome.
    inputBinding:
      position: 101
      prefix: --custom-genome
  - id: default_pos
    type:
      - 'null'
      - string
    doc: Set the initial viewing coordinates for the hub.
    inputBinding:
      position: 101
      prefix: --default-pos
  - id: description_file
    type:
      - 'null'
      - File
    doc: Path to an HTML file to display as the hub's landing 
      page/documentation.
    inputBinding:
      position: 101
      prefix: --description
  - id: genome_name
    type:
      - 'null'
      - string
    doc: The genome assembly ID (e.g., hg38, mm10). For custom genomes, use this
      as the assembly name.
    inputBinding:
      position: 101
      prefix: --genome-name
  - id: hub_email
    type:
      - 'null'
      - string
    doc: Contact email displayed on the hub's description page.
    inputBinding:
      position: 101
      prefix: --hub-email
  - id: hub_name
    type:
      - 'null'
      - string
    doc: The short identifier for the hub (used in UCSC URL).
    inputBinding:
      position: 101
      prefix: --hub-name
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: A list of local track files (bigWig, bigBed, BAM, etc.) to include in 
      the hub.
    inputBinding:
      position: 101
      prefix: --input-files
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to a CSV/TSV containing track metadata. Must include a 'fn' column
      with file paths.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: organism
    type:
      - 'null'
      - string
    doc: Required for custom genomes. Common name of the organism (e.g., 
      'Human', 'Mouse').
    inputBinding:
      position: 101
      prefix: --organism
  - id: overlay_by
    type:
      - 'null'
      - string
    doc: Metadata columns to define OverlayTracks (e.g., multi-signal plots).
    inputBinding:
      position: 101
      prefix: --overlay-by
  - id: seqnado
    type:
      - 'null'
      - boolean
    doc: Automatically extract sample metadata using the seqnado directory 
      structure convention.
    inputBinding:
      position: 101
      prefix: --seqnado
  - id: subgroup_by
    type:
      - 'null'
      - string
    doc: Metadata columns to define multi-dimensional CompositeTracks (matrix 
      display).
    inputBinding:
      position: 101
      prefix: --subgroup-by
  - id: supergroup_by
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more metadata columns to use for top-level track grouping 
      (SuperTracks).
    inputBinding:
      position: 101
      prefix: --supergroup-by
  - id: twobit
    type:
      - 'null'
      - File
    doc: Required for custom genomes. Path to the .2bit file containing the 
      genome sequence.
    inputBinding:
      position: 101
      prefix: --twobit
  - id: url_prefix
    type:
      - 'null'
      - string
    doc: Base URL where the hub will be hosted (used for final URL reporting).
    inputBinding:
      position: 101
      prefix: --url-prefix
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: The directory where the staged hub and tracknado_config.json will be 
      created.
    outputBinding:
      glob: $(inputs.output)
  - id: template
    type:
      - 'null'
      - File
    doc: Create a template metadata file at the specified path and exit.
    outputBinding:
      glob: $(inputs.template)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
