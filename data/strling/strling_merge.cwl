cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling merge
label: strling_merge
doc: "Merge bin files previously created by `strling extract`\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bins
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more bin files previously created by `strling extract`
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: 'Annoated bed file specifying additional STR loci to genotype. Format is:
      chr start stop repeatunit [name]'
    inputBinding:
      position: 102
      prefix: --bed
  - id: chromosome
    type:
      - 'null'
      - string
    doc: chromosome to restrict parsing. helps with memory/parallelization for 
      large cohorts
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: diff_refs
    type:
      - 'null'
      - boolean
    doc: allow bin files generated on a mixture of reference genomes (by default
      differing references will produce an error). Reports chromosomes in the 
      first bin or -f if provided
    inputBinding:
      position: 102
      prefix: --diff-refs
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to fasta file (required if using CRAM input)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: min_clip
    type:
      - 'null'
      - int
    doc: minimum number of supporting clipped reads for each side of a locus
    inputBinding:
      position: 102
      prefix: --min-clip
  - id: min_clip_total
    type:
      - 'null'
      - int
    doc: minimum total number of supporting clipped reads for a locus
    inputBinding:
      position: 102
      prefix: --min-clip-total
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (does not apply to STR reads)
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads required in at least one individual 
      for a locus to be reported
    inputBinding:
      position: 102
      prefix: --min-support
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files. Suffix will be -bounds.txt
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Number of bp within which to search for reads supporting the other side
      of a bound. Estimated from the insert size distribution by default.
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
stdout: strling_merge.out
