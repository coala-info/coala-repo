cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamm_extract
label: bamm_extract
doc: "Extract reads which hit the given references\n\nTool homepage: https://github.com/Ecogenomics/BamM"
inputs:
  - id: bamfiles
    type:
      type: array
      items: File
    doc: bam files to parse
    inputBinding:
      position: 1
  - id: groups
    type:
      type: array
      items: File
    doc: files containing reference names (1 per line) or contigs file in fasta 
      format
    inputBinding:
      position: 2
  - id: headers_only
    type:
      - 'null'
      - boolean
    doc: extract only (unique) headers
    inputBinding:
      position: 103
      prefix: --headers_only
  - id: interleave
    type:
      - 'null'
      - boolean
    doc: interleave paired reads in ouput files
    inputBinding:
      position: 103
      prefix: --interleave
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 103
      prefix: --mapping_quality
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum allowable edit distance from query to reference
    default: 1000
    inputBinding:
      position: 103
      prefix: --max_distance
  - id: mix_bams
    type:
      - 'null'
      - boolean
    doc: use the same file for multiple bam files
    inputBinding:
      position: 103
      prefix: --mix_bams
  - id: mix_groups
    type:
      - 'null'
      - boolean
    doc: use the same files for multiple groups
    inputBinding:
      position: 103
      prefix: --mix_groups
  - id: mix_reads
    type:
      - 'null'
      - boolean
    doc: use the same files for paired/unpaired reads
    inputBinding:
      position: 103
      prefix: --mix_reads
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
    doc: write to this folder
    default: .
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
    doc: maximum number of threads to use
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the secondary flag
    inputBinding:
      position: 103
      prefix: --use_secondary
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the supplementary flag
    inputBinding:
      position: 103
      prefix: --use_supplementary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
stdout: bamm_extract.out
