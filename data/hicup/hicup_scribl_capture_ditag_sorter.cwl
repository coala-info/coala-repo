cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scribl_capture_ditag_sorter.pl]
label: hicup_scribl_capture_ditag_sorter
doc: "Determine SCRiBL capture efficiencies by region. Takes SCRiBL bait coordinates and HiCUP BAM/SAM files, counts the reads in each bait region, and writes the reads of each bait to its own file. Output files are written beside the input files.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: baits
    type: File
    doc: "Tab-delimited bait file with one header line (Bait_Name, Chromosome, Start, End)"
    inputBinding:
      position: 1
      prefix: --baits
  - id: sam_bam_files
    type: File[]
    doc: "HiCUP output BAM/SAM files"
    inputBinding:
      position: 100
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: region_files
    type: File[]
    doc: "Reads captured by each bait"
    outputBinding:
      glob: "*_captured.txt*"
  - id: summary
    type: File
    doc: "Capture summary table by region"
    outputBinding:
      glob: "capture_summary_scribl_regions.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
