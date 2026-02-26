cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga rewrite-evidence-bam
label: sga_rewrite-evidence-bam
doc: "Discard mate-pair alignments from a BAM file that are potentially erroneous\n\
  \nTool homepage: https://github.com/jts/sga"
inputs:
  - id: evidence_bam_file
    type: File
    doc: EVIDENCE_BAM_FILE
    inputBinding:
      position: 1
  - id: fastq
    type: File
    doc: parse the read names and sequences from the fastq file in F (required)
    inputBinding:
      position: 102
      prefix: --fastq
  - id: merge_bam
    type:
      - 'null'
      - File
    doc: merge the evidence BAM alignments with the alignments in F
    inputBinding:
      position: 102
      prefix: --merge-bam
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write the new BAM file to F
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
