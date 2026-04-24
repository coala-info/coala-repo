cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantify
label: flair_quantify
doc: "takes in many long-read RNA-seq reads files and quantifies them against a single
  transcriptome. A stringent, full-read-match-based approach\n\nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: check_splice
    type:
      - 'null'
      - boolean
    doc: enforce coverage of 4 out of 6 bp around each splice site and no insertions
      greater than 3 bp at the splice site
    inputBinding:
      position: 101
      prefix: --check_splice
  - id: generate_map
    type:
      - 'null'
      - boolean
    doc: create read-to-isoform assignment files for each sample
    inputBinding:
      position: 101
      prefix: --generate_map
  - id: isoform_bed
    type:
      - 'null'
      - File
    doc: isoform .bed file, must be specified if --stringent or check_splice is specified
    inputBinding:
      position: 101
      prefix: --isoform_bed
  - id: isoforms
    type: File
    doc: FastA of FLAIR collapsed isoforms
    inputBinding:
      position: 101
      prefix: --isoforms
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum MAPQ of read assignment to an isoform
    inputBinding:
      position: 101
      prefix: --quality
  - id: reads_manifest
    type: File
    doc: Tab delimited file containing sample id, condition, batch, reads.fq
    inputBinding:
      position: 101
      prefix: --reads_manifest
  - id: sample_id_only
    type:
      - 'null'
      - boolean
    doc: only use sample id in output header
    inputBinding:
      position: 101
      prefix: --sample_id_only
  - id: stringent
    type:
      - 'null'
      - boolean
    doc: Supporting reads must cover 80 percent of their isoform and extend at least
      25 nt into the first and last exons.
    inputBinding:
      position: 101
      prefix: --stringent
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: directory to put temporary files. use './' to indicate current directory
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: minimap2 number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tpm
    type:
      - 'null'
      - boolean
    doc: Convert counts matrix to transcripts per million and output as a separate
      file named <output>.tpm.tsv
    inputBinding:
      position: 101
      prefix: --tpm
  - id: trust_ends
    type:
      - 'null'
      - boolean
    doc: specify if reads are generated from a long read method with minimal fragmentation
    inputBinding:
      position: 101
      prefix: --trust_ends
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name base for FLAIR quantify
    outputBinding:
      glob: $(inputs.output)
  - id: output_bam
    type:
      - 'null'
      - File
    doc: whether to output bam file of reads aligned to correct isoforms
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
