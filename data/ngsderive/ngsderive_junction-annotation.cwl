cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive junction-annotation
label: ngsderive_junction-annotation
doc: "Annotate junctions from NGS files based on a gene model.\n\nTool homepage: https://github.com/claymcleod/ngsderive"
inputs:
  - id: ngsfiles
    type:
      type: array
      items: File
    doc: Next-generation sequencing files to process (BAM or FASTQ).
    inputBinding:
      position: 1
  - id: consider_unannotated_references_novel
    type:
      - 'null'
      - boolean
    doc: For the summary report, consider all events on unannotated reference 
      sequences `complete_novel`. Default is to exclude them from the summary. 
      Either way, they will be annotated as `unannotated_reference` in the 
      junctions file.
    default: false
    inputBinding:
      position: 102
      prefix: --consider-unannotated-references-novel
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable DEBUG log level.
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: disable_junction_files
    type:
      - 'null'
      - boolean
    doc: Disable generating junction files.
    default: false
    inputBinding:
      position: 102
      prefix: --disable-junction-files
  - id: fuzzy_junction_match_range
    type:
      - 'null'
      - int
    doc: Consider found splices within `+-k` bases of a known splice event 
      annotated.
    default: 0
    inputBinding:
      position: 102
      prefix: --fuzzy-junction-match-range
  - id: gene_model
    type: File
    doc: Gene model as a GFF/GTF file.
    default: None
    inputBinding:
      position: 102
      prefix: --gene-model
  - id: junction_files_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write annotated junction files to.
    default: ./
    inputBinding:
      position: 102
      prefix: --junction-files-dir
  - id: min_intron
    type:
      - 'null'
      - int
    doc: Minimum size of intron to be considered a splice.
    default: 50
    inputBinding:
      position: 102
      prefix: --min-intron
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ to consider for supporting reads.
    default: 30
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Filter any junctions that don't have at least `m` reads.
    default: 2
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable INFO log level.
    default: false
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write to filename rather than standard out.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
