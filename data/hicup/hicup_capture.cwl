cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_capture
label: hicup_capture
doc: 'For Capture Hi-C (CHiC) experiments. Takes a baits file and BAM/SAM HiCUP file(s)
  and separates ''captured'' di-tags from ''uncaptured'' di-tags, writing the output
  into two different BAM files. Reports summary statistics on the results. The output
  files are written beside the input files.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: sam_bam_files
    type:
      type: array
      items: File
    doc: HiCUP SAM/BAM files (staged writable because the outputs are written beside
      them)
    inputBinding:
      position: 2
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: baits
    type: File
    doc: 'Baits format file: tab-delimited Chromosome, Start, End (and a bait name
      in a fourth column when --interactions is used)'
    inputBinding:
      position: 103
      prefix: --baits
  - id: header
    type:
      - 'null'
      - int
    doc: Specify number of header lines in the baits file (i.e. skip these) [Default
      0]
    inputBinding:
      position: 103
      prefix: --header
  - id: interactions
    type:
      - 'null'
      - boolean
    doc: Calculate interaction frequencies between baits
    inputBinding:
      position: 103
      prefix: --interactions
outputs:
  - id: captured_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file of captured di-tags
    outputBinding:
      glob: '*.captured.bam'
  - id: uncaptured_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file of uncaptured di-tags
    outputBinding:
      glob: '*.uncaptured.bam'
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: Capture summary table
    outputBinding:
      glob: '*.capture_summary.txt'
  - id: charts
    type:
      - 'null'
      - type: array
        items: File
    doc: Capture charts (PDF)
    outputBinding:
      glob: '*.capture_charts.pdf'
  - id: interactions_table
    type:
      - 'null'
      - type: array
        items: File
    doc: Bait-bait interaction tables (with --interactions)
    outputBinding:
      glob: '*.interactions_*ordered.txt'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
