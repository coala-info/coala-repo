cwlVersion: v1.2
class: CommandLineTool
baseCommand: TPMCalculator
label: tpmcalculator_TPMCalculator
doc: "TPMCalculator calculates TPM values for genes and transcripts from BAM files
  and a GTF annotation.\n\nTool homepage: https://github.com/ncbi/TPMCalculator"
inputs:
  - id: bam_directory
    type:
      - 'null'
      - Directory
    doc: Directory with the BAM files
    inputBinding:
      position: 101
      prefix: -d
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: Extended output. This will include transcript level TPM values.
    inputBinding:
      position: 101
      prefix: -e
  - id: gene_key
    type:
      - 'null'
      - string
    doc: Gene key to use from GTF file
    inputBinding:
      position: 101
      prefix: -k
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: GTF file
    inputBinding:
      position: 101
      prefix: -g
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: Smaller size allowed for an intron created for genes. We recommend to 
      use the reads length
    inputBinding:
      position: 101
      prefix: -c
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ value to filter out reads. This value depends on the 
      aligner MAPQ value.
    inputBinding:
      position: 101
      prefix: -q
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap between a reads and a feature.
    inputBinding:
      position: 101
      prefix: -o
  - id: print_all_features
    type:
      - 'null'
      - boolean
    doc: Print out all features with read counts equal to zero.
    inputBinding:
      position: 101
      prefix: -a
  - id: print_info
    type:
      - 'null'
      - boolean
    doc: Print info
    inputBinding:
      position: 101
      prefix: -v
  - id: properly_paired_only
    type:
      - 'null'
      - boolean
    doc: Use only properly paired reads. Recommended for paired-end reads.
    inputBinding:
      position: 101
      prefix: -p
  - id: transcript_key
    type:
      - 'null'
      - string
    doc: Transcript key to use from GTF file
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: genes_out
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene level TPM values (*_genes.out)
    outputBinding:
      glob: '*_genes.out'
  - id: genes_ent
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene level read counts per feature (*_genes.ent)
    outputBinding:
      glob: '*_genes.ent'
  - id: transcripts_out
    type:
      - 'null'
      - type: array
        items: File
    doc: Transcript level TPM values (*_transcripts.out), written with -e
    outputBinding:
      glob: '*_transcripts.out'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tpmcalculator:0.0.6--h2bd4fab_0
stdout: tpmcalculator_TPMCalculator.out
