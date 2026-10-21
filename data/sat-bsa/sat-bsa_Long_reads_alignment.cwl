cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Sat-BSA
  - -w
  - Long_reads_alignment
label: sat-bsa_Long_reads_alignment
doc: "Align long reads to a reference with Minimap2 and write sorted, indexed BAM files per sample.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs:
  - id: aligned_read_list
    type: File
    doc: Full path of aligned_read_list.txt listing sequence reads applied to Minimap2 (Input format 3).
    inputBinding:
      position: 1
      prefix: -f
  - id: reference_fasta
    type: File
    doc: Full path of fasta file used as reference.
    inputBinding:
      position: 2
      prefix: -r
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: The mapping quality value excluded from analysis. Default is 0.
    inputBinding:
      position: 3
      prefix: -q
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number.
    inputBinding:
      position: 4
      prefix: -t
  - id: read_type
    type:
      - 'null'
      - string
    doc: The used sequence reads type, ont (Oxford Nanopore Technologies) or pb (PacBio). Default is ont.
    inputBinding:
      position: 5
      prefix: -i
  - id: data_files
    type:
      type: array
      items: File
    doc: Files named in the list files (bam, fasta, fastq, reference, gtf). They are staged into the working directory /work, so list files must name them as /work/<file name>.
outputs:
  - id: sorted_bams
    type:
      type: array
      items: File
    doc: Sorted BAM file per sample
    outputBinding:
      glob: "*.sort.bam"
  - id: bam_indexes
    type:
      type: array
      items: File
    doc: BAM index per sample
    outputBinding:
      glob: "*.sort.bam.bai"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
    dockerOutputDirectory: /work
