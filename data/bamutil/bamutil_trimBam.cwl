cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - trimBam
label: bamutil_trimBam
doc: "Trim the ends of reads in a SAM/BAM file changing read ends to 'N' and quality\
  \ to '!' or softclipping the ends (resulting file will not be sorted)\n\nTool homepage:\
  \ http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in_file
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: output SAM/BAM file
    inputBinding:
      position: 2
  - id: num_trim
    type:
      - 'null'
      - int
    doc: number of bases to trim on each side
    inputBinding:
      position: 3
  - id: left
    type:
      - 'null'
      - int
    doc: number of bases to trim from the left
    inputBinding:
      position: 4
      prefix: --left
  - id: right
    type:
      - 'null'
      - int
    doc: number of bases to trim from the right
    inputBinding:
      position: 4
      prefix: --right
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: ignore the strand information and treat forward/reverse the same
    inputBinding:
      position: 4
      prefix: --ignoreStrand
  - id: clip
    type:
      - 'null'
      - boolean
    doc: soft clip instead of modifying the sequence or quality
    inputBinding:
      position: 4
      prefix: --clip
outputs:
  - id: output_file
    type: File
    doc: Trimmed SAM/BAM file
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
