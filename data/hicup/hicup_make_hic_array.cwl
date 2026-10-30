cwlVersion: v1.2
class: CommandLineTool
baseCommand: [make_hic_array.pl]
label: hicup_make_hic_array
doc: "Convert the reads of HiCUP BAM/SAM files to restriction fragments and count the fragment-fragment interactions. Output files are written beside the input files.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: digest
    type: File
    doc: "HiCUP digest file (made by hicup_digester)"
    inputBinding:
      position: 1
      prefix: --digest
  - id: sam_bam_files
    type: File[]
    doc: "HiCUP output BAM/SAM files"
    inputBinding:
      position: 100
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: interaction_matrix
    type: File[]
    doc: "Fragment interaction matrix (gzip text; the tool spells the name matix)"
    outputBinding:
      glob: "*.fragment_interaction_matix.txt.gz"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sam_bam_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
