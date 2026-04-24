cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_extract
label: groopm_extract
doc: "Extract contigs or reads based on bin affiliations\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: data
    type:
      type: array
      items: File
    doc: data file(s) to extract from, bam or fasta
    inputBinding:
      position: 2
  - id: bids
    type:
      - 'null'
      - type: array
        items: string
    doc: bin ids to use (None for all)
    inputBinding:
      position: 103
      prefix: --bids
  - id: cutoff
    type:
      - 'null'
      - int
    doc: '>>CONTIG MODE ONLY<< cutoff contig size (0 for no cutoff)'
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: headers_only
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< extract only (unique) headers'
    inputBinding:
      position: 103
      prefix: --headers_only
  - id: interleave
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< interleave paired reads in ouput files'
    inputBinding:
      position: 103
      prefix: --interleave
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: '>>READ MODE ONLY<< mapping quality threshold'
    inputBinding:
      position: 103
      prefix: --mapping_quality
  - id: max_distance
    type:
      - 'null'
      - int
    doc: '>>READ MODE ONLY<< maximum allowable edit distance from query to reference'
    inputBinding:
      position: 103
      prefix: --max_distance
  - id: mix_bams
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< use the same file for multiple bam files'
    inputBinding:
      position: 103
      prefix: --mix_bams
  - id: mix_groups
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< use the same files for multiple group groups'
    inputBinding:
      position: 103
      prefix: --mix_groups
  - id: mix_reads
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< use the same files for paired/unpaired reads'
    inputBinding:
      position: 103
      prefix: --mix_reads
  - id: mode
    type:
      - 'null'
      - string
    doc: what to extract [reads, contigs]
    inputBinding:
      position: 103
      prefix: --mode
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: do not gzip output files
    inputBinding:
      position: 103
      prefix: --no_gzip
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: write to this folder (None for current dir)
    inputBinding:
      position: 103
      prefix: --out_folder
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to apply to output files
    inputBinding:
      position: 103
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: '>>READ MODE ONLY<< maximum number of threads to use'
    inputBinding:
      position: 103
      prefix: --threads
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< use reads marked with the secondary flag'
    inputBinding:
      position: 103
      prefix: --use_secondary
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< use reads marked with the supplementary flag'
    inputBinding:
      position: 103
      prefix: --use_supplementary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: '>>READ MODE ONLY<< be verbose'
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_extract.out
