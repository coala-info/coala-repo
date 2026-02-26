cwlVersion: v1.2
class: CommandLineTool
baseCommand: virprof_blastbin
label: virprof_blastbin
doc: "Merge and classify contigs based on BLAST search results\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: cache_path
    type:
      - 'null'
      - Directory
    doc: Location for caching of remote data
    inputBinding:
      position: 101
      prefix: --cache-path
  - id: chain_penalty
    type:
      - 'null'
      - int
    doc: Cost to BLAST score for concatenating two hits
    inputBinding:
      position: 101
      prefix: --chain-penalty
  - id: exclude
    type:
      - 'null'
      - string
    doc: Add NCBI taxonomy scientific names to list of taxa omitted from final 
      results. Use 'None' to disable default (Hominidae)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: genome_size
    type:
      - 'null'
      - boolean
    doc: Obtain genome sizes for bins from NCBI
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: in_blast7
    type: File
    doc: BLAST result file in format 7
    inputBinding:
      position: 101
      prefix: --in-blast7
  - id: in_coverage
    type:
      - 'null'
      - File
    doc: Samtools coverage result files
    inputBinding:
      position: 101
      prefix: --in-coverage
  - id: in_fastaqc
    type:
      - 'null'
      - File
    doc: VirProf FastA QC reports (entropies, homopolymers)
    inputBinding:
      position: 101
      prefix: --in-fastaqc
  - id: include
    type:
      - 'null'
      - string
    doc: Add NCBI taxonomy scientific names to list of taxa included in final 
      results.
    inputBinding:
      position: 101
      prefix: --include
  - id: max_pcthp
    type:
      - 'null'
      - int
    doc: Exclude contigs with higher homopolymer percentage. Requires 
      --in-fastaqc to be set to take effect.
    inputBinding:
      position: 101
      prefix: --max-pcthp
  - id: min_read_count
    type:
      - 'null'
      - int
    doc: Exclude contigs with less than this number of reads. Requires 
      --in-coverage to be set to take effect.
    inputBinding:
      position: 101
      prefix: --min-read-count
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API Key
    inputBinding:
      position: 101
      prefix: --ncbi-api-key
  - id: ncbi_taxonomy
    type: Directory
    doc: Path to NCBI taxonomy (tree or raw)
    inputBinding:
      position: 101
      prefix: --ncbi-taxonomy
  - id: no_genome_size
    type:
      - 'null'
      - boolean
    doc: Do not obtain genome sizes for bins from NCBI
    inputBinding:
      position: 101
      prefix: --no-genome-size
  - id: no_standard_excludes
    type:
      - 'null'
      - boolean
    doc: Do not exclude Human, artificial and unclassified sequences by default
    inputBinding:
      position: 101
      prefix: --no-standard-excludes
  - id: num_words
    type:
      - 'null'
      - int
    doc: Number of words to add to 'words' field
    inputBinding:
      position: 101
      prefix: --num-words
  - id: prefilter_contigs
    type:
      - 'null'
      - string
    doc: Add NCBI taxonomy scientific names to list of taxa filtered from input 
      contigs as classified by relaxed LCA on input BLAST results. Use 'None' to
      disable default (Euteleostomi).
    inputBinding:
      position: 101
      prefix: --prefilter-contigs
  - id: prefilter_hits
    type:
      - 'null'
      - string
    doc: Add NCBI taxonomy scientific names to list of taxa filtered from input 
      BLAST search results. If within 90% bitscore of the top hit more than half
      the hits are removed by this filter, the entire contig is excluded. Use 
      'None' to disable default (various artificial, unclassified and uncultured
      taxonomy nodes).
    inputBinding:
      position: 101
      prefix: --prefilter-hits
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output CSV file containing final calls (one row per bin)
    outputBinding:
      glob: $(inputs.out)
  - id: out_hits
    type: File
    doc: Output CSV file containining contig details (one row per hit)
    outputBinding:
      glob: $(inputs.out_hits)
  - id: out_features
    type:
      - 'null'
      - File
    doc: Output CSV file containing reference feature annotation (one row per 
      feature)
    outputBinding:
      glob: $(inputs.out_features)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
