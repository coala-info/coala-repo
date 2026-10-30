cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scribler]
label: hicup_scribler
doc: "Create a SeqMonk data file for SCRiBL datasets. Each bait region is imported into SeqMonk as a separate chromosome. Reads are only considered captured if both reads of a di-tag overlap the SCRiBL capture region. Output files are written beside the input files.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: baits
    type: File
    doc: "Bait file, tab-delimited: Chromosome, Bait_Start, Bait_End, Bait_Name"
    inputBinding:
      position: 1
      prefix: --baits
  - id: annotation
    type: ['null', boolean]
    doc: "Create a custom annotation for the SCRiBL baits (compatible with SeqMonk); needs the annotation_files"
    inputBinding:
      position: 2
      prefix: --annotation
  - id: annotation_files
    type: ['null', 'File[]']
    doc: "EMBL format genome annotation files named [chromosome name].dat, staged in the working directory for --annotation"
  - id: digest
    type: ['null', File]
    doc: "HiCUP digest file used to create a SCRiBL digest annotation file for SeqMonk"
    inputBinding:
      position: 3
      prefix: --digest
      valueFrom: $(self.basename)
  - id: seqmonk
    type: ['null', boolean]
    doc: "Edit the annotation file to remove common irregularities that make it incompatible with BioPerl (only with --annotation)"
    inputBinding:
      position: 4
      prefix: --seqmonk
  - id: sam
    type: ['null', boolean]
    doc: "Do not compress the captured reads files (write SAM, not BAM)"
    inputBinding:
      position: 5
      prefix: --sam
  - id: autoedit
    type: ['null', boolean]
    doc: "Rename baits that contain prohibited characters (bait names may only contain alphanumeric characters)"
    inputBinding:
      position: 6
      prefix: --autoedit
  - id: sam_bam_files
    type: File[]
    doc: "HiCUP BAM/SAM output files"
    inputBinding:
      position: 100
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: both_captured
    type: ['null', 'File[]']
    doc: "Di-tags with both reads captured"
    outputBinding:
      glob: "*.both_captured.*"
  - id: one_captured
    type: ['null', 'File[]']
    doc: "Di-tags with one read captured"
    outputBinding:
      glob: "*.one_captured.*"
  - id: uncaptured
    type: ['null', 'File[]']
    doc: "Di-tags with no read captured"
    outputBinding:
      glob: "*.uncaptured.*"
  - id: summary
    type: ['null', File]
    doc: "Capture summary table"
    outputBinding:
      glob: capture_summary.txt
  - id: digest_annotation
    type: ['null', File]
    doc: "SeqMonk digest annotation track"
    outputBinding:
      glob: "*.scribl.txt"
  - id: bait_annotations
    type: ['null', 'File[]']
    doc: "Bait annotation files ([bait name].dat)"
    outputBinding:
      glob: "*.dat"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
      - entry: $(inputs.digest)
        writable: true
      - entry: $(inputs.annotation_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
