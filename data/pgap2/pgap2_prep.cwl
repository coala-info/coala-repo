cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgap2_prep
label: pgap2_prep
doc: "Prepares input data for pgap2.\n\nTool homepage: https://github.com/bucongfan/PGAP2"
inputs:
  - id: accurate
    type:
      - 'null'
      - boolean
    doc: Apply bidirection check for paralogous gene partition.
    inputBinding:
      position: 101
      prefix: --accurate
  - id: al
    type:
      - 'null'
      - float
    doc: Coverage for the longer sequence.
    inputBinding:
      position: 101
      prefix: --AL
  - id: aligner
    type:
      - 'null'
      - string
    doc: The aligner used to pairwise alignment.
    inputBinding:
      position: 101
      prefix: --aligner
  - id: ani_thre
    type:
      - 'null'
      - int
    doc: Expect ani threshold
    inputBinding:
      position: 101
      prefix: --ani_thre
  - id: annot
    type:
      - 'null'
      - boolean
    doc: Discard original annotation, and re-annote the genome privately using 
      prodigal
    inputBinding:
      position: 101
      prefix: --annot
  - id: as
    type:
      - 'null'
      - float
    doc: Coverage for the shorter sequence.
    inputBinding:
      position: 101
      prefix: --AS
  - id: clust_method
    type:
      - 'null'
      - string
    doc: The method used to cluster the genes.
    inputBinding:
      position: 101
      prefix: --clust_method
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode. Note: very verbose'
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable
    type:
      - 'null'
      - boolean
    doc: Disable progress bar
    inputBinding:
      position: 101
      prefix: --disable
  - id: dup_id
    type:
      - 'null'
      - float
    doc: The maximum identity between the most recent duplication envent.
    inputBinding:
      position: 101
      prefix: --dup_id
  - id: evalue
    type:
      - 'null'
      - float
    doc: The evalue of aligner.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: gcode
    type:
      - 'null'
      - int
    doc: The genetic code of your species. Default is [11] (bacteria).
    inputBinding:
      position: 101
      prefix: --gcode
  - id: id_attr_key
    type:
      - 'null'
      - string
    doc: Only for gff file as input, Attribute key to extract from the 9th 
      column as the record ID (e.g., 'ID', 'gene', 'locus_tag').
    inputBinding:
      position: 101
      prefix: --id-attr-key
  - id: indir
    type: Directory
    doc: Input file contained, same prefix seems as the same strain.
    inputBinding:
      position: 101
      prefix: --indir
  - id: ld
    type:
      - 'null'
      - float
    doc: Minimum gene length difference proportion between two genes.
    inputBinding:
      position: 101
      prefix: --LD
  - id: marker
    type:
      - 'null'
      - string
    doc: Assigned darb or outlier strain used to filter the input. See detail in
      marker.cfg in the main path
    inputBinding:
      position: 101
      prefix: --marker
  - id: max_targets
    type:
      - 'null'
      - int
    doc: The maximum targets for each query in alignment. Improves accuracy for 
      large-scale analyses, but increases runtime and memory usage.
    inputBinding:
      position: 101
      prefix: --max_targets
  - id: min_falen
    type:
      - 'null'
      - int
    doc: protein length of throw_away_sequences, at least 11
    inputBinding:
      position: 101
      prefix: --min_falen
  - id: nodraw
    type:
      - 'null'
      - boolean
    doc: Only output flat file, but no drawing plot
    inputBinding:
      position: 101
      prefix: --nodraw
  - id: orth_id
    type:
      - 'null'
      - float
    doc: The maximum identity between the most similar panclusters, 0 means 
      automatic selection.
    inputBinding:
      position: 101
      prefix: --orth_id
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: para_id
    type:
      - 'null'
      - float
    doc: Use this identity as the paralogous identity, 0 means automatic 
      selection.
    inputBinding:
      position: 101
      prefix: --para_id
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieving gene that may lost with annotations
    inputBinding:
      position: 101
      prefix: --retrieve
  - id: single_file
    type:
      - 'null'
      - boolean
    doc: Output each vector plot as a single file
    inputBinding:
      position: 101
      prefix: --single_file
  - id: threads
    type:
      - 'null'
      - int
    doc: threads used in parallel
    inputBinding:
      position: 101
      prefix: --threads
  - id: type_filter
    type:
      - 'null'
      - string
    doc: Only for gff file as input, feature type (3rd column) to include, Only 
      lines matching these types will be processed.
    inputBinding:
      position: 101
      prefix: --type-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
stdout: pgap2_prep.out
