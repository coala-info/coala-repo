cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scribl_capture.pl]
label: hicup_scribl_capture
doc: "Determine capture efficiencies of SCRiBL datasets. Takes SCRiBL bait coordinates and HiCUP BAM/SAM files, and writes captured and uncaptured di-tags to BAM files plus capture_summary.txt. Output files are written beside the input files.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: baits
    type: File
    doc: "Tab-delimited bait file (Chromosome, Start, End; no header)"
    inputBinding:
      position: 1
      prefix: --baits
  - id: zip
    type: ['null', boolean]
    doc: "Write BAM output (the script always zips)"
    inputBinding:
      position: 2
      prefix: --zip
  - id: sam_bam_files
    type: File[]
    doc: "HiCUP output BAM/SAM files"
    inputBinding:
      position: 100
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: captured
    type: File[]
    doc: "Captured di-tags"
    outputBinding:
      glob: "*_captured.bam"
  - id: uncaptured
    type: File[]
    doc: "Uncaptured di-tags"
    outputBinding:
      glob: "*_uncaptured.bam"
  - id: summary
    type: File
    doc: "Capture summary table"
    outputBinding:
      glob: "capture_summary.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
