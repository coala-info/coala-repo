cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgap2 main
label: pgap2_main
doc: "Main entry point for pgap2.\n\nTool homepage: https://github.com/bucongfan/PGAP2"
inputs:
  - id: accurate
    type:
      - 'null'
      - boolean
    doc: Apply bidirection check for paralogous gene partition (useless if 
      exhaust_orth asigned).
    default: false
    inputBinding:
      position: 101
      prefix: --accurate
  - id: al
    type:
      - 'null'
      - float
    doc: Coverage for the longer sequence.
    default: 0.6
    inputBinding:
      position: 101
      prefix: --AL
  - id: aligner
    type:
      - 'null'
      - string
    doc: The aligner used to pairwise alignment.
    default: diamond
    inputBinding:
      position: 101
      prefix: --aligner
  - id: annot
    type:
      - 'null'
      - boolean
    doc: Discard original annotation, and re-annote the genome privately using 
      prodigal
    default: false
    inputBinding:
      position: 101
      prefix: --annot
  - id: as
    type:
      - 'null'
      - float
    doc: Coverage for the shorter sequence.
    default: 0.6
    inputBinding:
      position: 101
      prefix: --AS
  - id: clust_method
    type:
      - 'null'
      - string
    doc: The method used to cluster the genes.
    default: mmseqs2
    inputBinding:
      position: 101
      prefix: --clust_method
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode. Note: very verbose'
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable
    type:
      - 'null'
      - boolean
    doc: Disable progress bar
    default: false
    inputBinding:
      position: 101
      prefix: --disable
  - id: dup_id
    type:
      - 'null'
      - float
    doc: The maximum identity between the most recent duplication envent.
    default: 0.99
    inputBinding:
      position: 101
      prefix: --dup_id
  - id: evalue
    type:
      - 'null'
      - float
    doc: The evalue of aligner.
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exhaust_orth
    type:
      - 'null'
      - boolean
    doc: Try to split every paralogs gene exhausted
    default: false
    inputBinding:
      position: 101
      prefix: --exhaust_orth
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Do not apply fine feature analysis just partition according to the gene
      identity and synteny.
    default: false
    inputBinding:
      position: 101
      prefix: --fast
  - id: gcode
    type:
      - 'null'
      - int
    doc: The genetic code of your species.
    default: 11
    inputBinding:
      position: 101
      prefix: --gcode
  - id: hconf_thre
    type:
      - 'null'
      - float
    doc: The threshold to define high confidence cluster which is used to 
      evaluate the cluster diversity. Loose this value when your input is too 
      large or too diverse, such as 0.95.
    default: 1
    inputBinding:
      position: 101
      prefix: --hconf_thre
  - id: id_attr_key
    type:
      - 'null'
      - string
    doc: Only for gff file as input, Attribute key to extract from the 9th 
      column as the record ID (e.g., 'ID', 'gene', 'locus_tag').
    default: ID
    inputBinding:
      position: 101
      prefix: --id-attr-key
  - id: indir
    type: File
    doc: Input file contained, same prefix seems as the same strain.
    inputBinding:
      position: 101
      prefix: --indir
  - id: ins
    type:
      - 'null'
      - boolean
    doc: Ignore the influence of insertion sequence.
    default: false
    inputBinding:
      position: 101
      prefix: --ins
  - id: ld
    type:
      - 'null'
      - float
    doc: Minimum gene length difference proportion between two genes.
    default: 0.6
    inputBinding:
      position: 101
      prefix: --LD
  - id: max_targets
    type:
      - 'null'
      - int
    doc: The maximum targets for each query in alignment. Improves accuracy for 
      large-scale analyses, but increases runtime and memory usage.
    default: 2000
    inputBinding:
      position: 101
      prefix: --max_targets
  - id: min_falen
    type:
      - 'null'
      - int
    doc: protein length of throw_away_sequences, at least 11
    default: 20
    inputBinding:
      position: 101
      prefix: --min_falen
  - id: orth_id
    type:
      - 'null'
      - float
    doc: The maximum identity between the most similar panclusters.
    default: 0.98
    inputBinding:
      position: 101
      prefix: --orth_id
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: para_id
    type:
      - 'null'
      - float
    doc: Use this identity as the paralogous identity.
    default: 0.7
    inputBinding:
      position: 101
      prefix: --para_id
  - id: radius
    type:
      - 'null'
      - int
    doc: The radius of search region.
    default: 3
    inputBinding:
      position: 101
      prefix: --radius
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieve gene that may lost with annotations
    default: false
    inputBinding:
      position: 101
      prefix: --retrieve
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: The degree of connectedness between each node of clust.
    default: strict
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: threads
    type:
      - 'null'
      - int
    doc: threads used in parallel
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: type_filter
    type:
      - 'null'
      - string
    doc: Only for gff file as input, feature type (3rd column) to include, Only 
      lines matching these types will be processed.
    default: CDS
    inputBinding:
      position: 101
      prefix: --type-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    default: false
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
stdout: pgap2_main.out
