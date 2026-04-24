cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - rna
label: vg_rna
doc: "Constructs a splicing graph from transcripts and a graph.\n\nTool homepage:
  https://github.com/vgteam/vg"
inputs:
  - id: graph_file
    type: File
    doc: Input graph file (vg, pg, hg, or gbz format)
    inputBinding:
      position: 1
  - id: add_hap_paths
    type:
      - 'null'
      - boolean
    doc: add projected transcripts as embedded paths
    inputBinding:
      position: 102
      prefix: --add-hap-paths
  - id: add_ref_paths
    type:
      - 'null'
      - boolean
    doc: add reference transcripts as embedded paths
    inputBinding:
      position: 102
      prefix: --add-ref-paths
  - id: do_not_sort
    type:
      - 'null'
      - boolean
    doc: do not topological sort and compact the graph
    inputBinding:
      position: 102
      prefix: --do-not-sort
  - id: feature_type
    type:
      - 'null'
      - string
    doc: parse only this feature type in the GTF/GFF (parses all if empty)
    inputBinding:
      position: 102
      prefix: --feature-type
  - id: gbwt_bidirectional
    type:
      - 'null'
      - boolean
    doc: use bidirectional paths in GBWT index construction
    inputBinding:
      position: 102
      prefix: --gbwt-bidirectional
  - id: gbz_format
    type:
      - 'null'
      - boolean
    doc: input graph is GBZ format (has graph & GBWT index)
    inputBinding:
      position: 102
      prefix: --gbz-format
  - id: haplotypes
    type:
      - 'null'
      - File
    doc: project transcripts onto haplotypes in GBWT index
    inputBinding:
      position: 102
      prefix: --haplotypes
  - id: introns
    type:
      - 'null'
      - type: array
        items: File
    doc: intron file(s) in bed format
    inputBinding:
      position: 102
      prefix: --introns
  - id: max_node_length
    type:
      - 'null'
      - int
    doc: chop nodes longer than INT (disable with 0)
    inputBinding:
      position: 102
      prefix: --max-node-length
  - id: out_exclude_ref
    type:
      - 'null'
      - boolean
    doc: exclude reference transcripts from pantranscriptome
    inputBinding:
      position: 102
      prefix: --out-exclude-ref
  - id: path_collapse
    type:
      - 'null'
      - string
    doc: collapse identical transcript paths across no|haplotype|all paths
    inputBinding:
      position: 102
      prefix: --path-collapse
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: proj_embed_paths
    type:
      - 'null'
      - boolean
    doc: project transcripts onto embedded haplotype paths
    inputBinding:
      position: 102
      prefix: --proj-embed-paths
  - id: remove_non_gene
    type:
      - 'null'
      - boolean
    doc: remove intergenic and intronic regions (deletes all paths in the graph)
    inputBinding:
      position: 102
      prefix: --remove-non-gene
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compute threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: transcript_tag
    type:
      - 'null'
      - string
    doc: use this attribute tag in the GTF/GFf file(s) as ID to group exons and 
      name paths
    inputBinding:
      position: 102
      prefix: --transcript-tag
  - id: transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: transcript file(s) in gtf/gff format
    inputBinding:
      position: 102
      prefix: --transcripts
  - id: use_hap_ref
    type:
      - 'null'
      - boolean
    doc: use haplotype paths in GBWT index as references (disables projection)
    inputBinding:
      position: 102
      prefix: --use-hap-ref
outputs:
  - id: write_gbwt
    type:
      - 'null'
      - File
    doc: write pantranscriptome transcript paths as GBWT
    outputBinding:
      glob: $(inputs.write_gbwt)
  - id: write_hap_gbwt
    type:
      - 'null'
      - File
    doc: write input haplotypes as a GBWT with node IDs matching the output 
      graph
    outputBinding:
      glob: $(inputs.write_hap_gbwt)
  - id: write_fasta
    type:
      - 'null'
      - File
    doc: write pantranscriptome transcript sequences to here
    outputBinding:
      glob: $(inputs.write_fasta)
  - id: write_info
    type:
      - 'null'
      - File
    doc: write pantranscriptome transcript info table as TSV
    outputBinding:
      glob: $(inputs.write_info)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
