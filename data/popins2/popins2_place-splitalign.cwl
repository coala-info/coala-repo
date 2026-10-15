cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, place-splitalign]
label: popins2_place-splitalign
doc: "Contig placing, step 2/3: split-read alignment of all locations in a sample's locations_unplaced.txt; writes locations_placed.txt.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Path to the sample directories. Default: '.' (the working directory, where the sample folders are staged)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: contigs
    type:
      - 'null'
      - File
    doc: "Supercontigs FASTA (default name supercontigs.fa); staged in the working directory"
    inputBinding:
      position: 1
      prefix: --contigs
      valueFrom: "$(self.basename)"
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - ".fai"
    doc: "Reference genome FASTA (default name genome.fa); staged in the working directory"
    inputBinding:
      position: 1
      prefix: --reference
      valueFrom: "$(self.basename)"
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: "The maximum expected insert size of the read pairs. Default: 800"
    inputBinding:
      position: 1
      prefix: --maxInsertSize
  - id: read_length
    type:
      - 'null'
      - int
    doc: "The length of the reads. Default: 100"
    inputBinding:
      position: 1
      prefix: --readLength
  - id: bam_file
    type: File
    secondaryFiles:
      - ".bai"
    doc: "Original BAM file of the sample (indexed); staged in the working directory under the name recorded in the sample folder (POPINS_SAMPLE_INFO)"
  - id: sample_id
    type: string
    doc: "Sample ID (name of the sample folder)"
    inputBinding:
      position: 100
  - id: sample_dir
    type: Directory
    doc: "Sample folder written by popins2 place-refalign (non_ref_new.bam, locations_unplaced.txt, ...)"
outputs:
  - id: sample_dir_out
    type: Directory
    doc: "Sample folder with locations_placed.txt"
    outputBinding:
      glob: "$(inputs.sample_id)"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.sample_id)
        entry: $(inputs.sample_dir)
        writable: true
      - $(inputs.reference)
      - $(inputs.contigs)
      - $(inputs.bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_place-splitalign.log
