cwlVersion: v1.2
class: CommandLineTool
baseCommand: jgi_summarize_bam_contig_depths
label: metabat2_jgi_summarize_bam_contig_depths
doc: "Summarize BAM contig depths for MetaBAT2 binning.\n\nTool homepage: https://bitbucket.org/berkeleylab/metabat"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: One or more BAM files to summarize
    inputBinding:
      position: 1
  - id: min_mq
    type:
      - 'null'
      - int
    doc: The minimum mapping quality of a read alignment to be included
    inputBinding:
      position: 102
      prefix: --minMQ
  - id: no_secondary
    type:
      - 'null'
      - boolean
    doc: Do not include secondary alignments
    inputBinding:
      position: 102
      prefix: --noSecondary
  - id: paired_only
    type:
      - 'null'
      - boolean
    doc: Only count properly paired reads
    inputBinding:
      position: 102
      prefix: --pairedOnly
  - id: percent_identity
    type:
      - 'null'
      - int
    doc: The minimum end-to-end % identity of a read alignment to be included
    inputBinding:
      position: 102
      prefix: --percentIdentity
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: The reference file used for alignment; used to verify contig lengths
    inputBinding:
      position: 102
      prefix: --referenceFasta
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Use shared memory for BAM reading
    inputBinding:
      position: 102
      prefix: --shm
outputs:
  - id: output_depth
    type: File
    doc: The file to put the contig depths in
    outputBinding:
      glob: $(inputs.output_depth)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabat2:2.18--h6f16272_0
