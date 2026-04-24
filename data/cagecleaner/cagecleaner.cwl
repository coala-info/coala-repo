cwlVersion: v1.2
class: CommandLineTool
baseCommand: cagecleaner
label: cagecleaner
doc: "CAGEcleaner: A tool to remove redundancy from cblaster hits. CAGEcleaner reduces
  redundancy in cblaster hit sets by dereplicating the genomes containing the hits.
  It can also recover hits that would have been omitted by this dereplication if they
  have a different gene cluster content or an outlier cblaster score.\n\nTool homepage:
  https://github.com/LucoDevro/CAGEcleaner"
inputs:
  - id: ani
    type:
      - 'null'
      - float
    doc: ANI dereplication threshold
    inputBinding:
      position: 101
      prefix: --ani
  - id: bypass_organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organisms in the binary table that should bypass dereplication 
      (comma-separated). These will end up in the final output in any case.
    inputBinding:
      position: 101
      prefix: --bypass_organisms
  - id: bypass_scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffold IDs in the binary table that should bypass dereplication 
      (comma-separated). These will end up in the final output in any case.
    inputBinding:
      position: 101
      prefix: --bypass_scaffolds
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: download_batch
    type:
      - 'null'
      - int
    doc: Number of genomes to download in one batch
    inputBinding:
      position: 101
      prefix: --download_batch
  - id: exclude_organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Organisms in the binary table to be excluded from the hit set 
      (comma-seperated).
    inputBinding:
      position: 101
      prefix: --exclude_organisms
  - id: exclude_scaffolds
    type:
      - 'null'
      - type: array
        items: string
    doc: Scaffolds IDs in the binary table to be excluded from the hit set 
      (comma-separated).
    inputBinding:
      position: 101
      prefix: --exclude_scaffolds
  - id: genome_dir
    type:
      - 'null'
      - Directory
    doc: '[Only relevant for local cblaster sessions] Path to local genome folder
      containing genome files. Accepted formats are FASTA and GenBank [.fasta; .fna;
      .fa; .gbff; .gbk; .gb]. Files can be gzipped. Folder can contain other files.'
    inputBinding:
      position: 101
      prefix: --genomes
  - id: keep_dereplication
    type:
      - 'null'
      - boolean
    doc: Keep skDER output
    inputBinding:
      position: 101
      prefix: --keep_dereplication
  - id: keep_downloads
    type:
      - 'null'
      - boolean
    doc: Keep downloaded genomes
    inputBinding:
      position: 101
      prefix: --keep_downloads
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate data. This overrules other keep flags.
    inputBinding:
      position: 101
      prefix: --keep_intermediate
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Use skDER's low-memory mode. Lowers memory requirements substantially 
      at the cost of a slightly lower representative quality.
    inputBinding:
      position: 101
      prefix: --low_mem
  - id: min_score_diff
    type:
      - 'null'
      - float
    doc: minimum cblaster score difference between hits to be considered 
      different. Discards outlier hits with a score difference below this 
      threshold.
    inputBinding:
      position: 101
      prefix: --min_score_diff
  - id: min_z_score
    type:
      - 'null'
      - float
    doc: z-score threshold to consider hits outliers
    inputBinding:
      position: 101
      prefix: --min_z_score
  - id: no_recovery_content
    type:
      - 'null'
      - boolean
    doc: Skip recovering hits by cluster content
    inputBinding:
      position: 101
      prefix: --no_recovery_content
  - id: no_recovery_score
    type:
      - 'null'
      - boolean
    doc: Skip recovering hits by outlier scores
    inputBinding:
      position: 101
      prefix: --no_recovery_score
  - id: session_file
    type: File
    doc: Path to cblaster session file
    inputBinding:
      position: 101
      prefix: --session
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to store temporary files
    inputBinding:
      position: 101
      prefix: --temp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cagecleaner:1.4.5--pyhdfd78af_0
