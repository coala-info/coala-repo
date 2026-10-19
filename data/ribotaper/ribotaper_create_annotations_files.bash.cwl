cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_annotations_files.bash
label: ribotaper_create_annotations_files.bash
doc: "Create the annotation files that RiboTaper needs from a GTF file and an indexed
  genome FASTA file.\n\nTool homepage: https://github.com/boboppie/RiboTaper"
inputs:
  - id: gtf_file
    type: File
    doc: GTF annotation file (GENCODE style)
    inputBinding:
      position: 1
  - id: genome_fasta
    type: File
    secondaryFiles:
      - .fai
    doc: Genome FASTA file (indexed with samtools faidx)
    inputBinding:
      position: 2
  - id: use_ccdsid
    type: string
    doc: Use the CCDS id to define CCDS transcripts (true or false)
    inputBinding:
      position: 3
  - id: use_appris
    type: string
    doc: Use APPRIS principal transcripts (true or false)
    inputBinding:
      position: 4
  - id: dest_folder
    type: string
    doc: Output folder for the annotation files; it is created before the run
    inputBinding:
      position: 5
outputs:
  - id: annotation_dir
    type: Directory
    doc: Folder with the RiboTaper annotation files
    outputBinding:
      glob: $(inputs.dest_folder)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.dest_folder, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper_create_annotations_files.bash.out
