cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - bam2fastq
label: sqt_bam2fastq
doc: "Extract all reads from a BAM file that map to a certain location, but try hard
  to extract them even if hard clipping is used.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: sam_bam
    type: File
    doc: Name of a SAM or BAM file
    inputBinding:
      position: 1
  - id: region
    type:
      type: array
      items: string
    doc: Region
    inputBinding:
      position: 2
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file with regions
    inputBinding:
      position: 103
      prefix: --bed
  - id: missing_quality
    type:
      - 'null'
      - int
    doc: Quality value to use if an entry does not have qualities
    inputBinding:
      position: 103
      prefix: --missing-quality
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_bam2fastq.out
