cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, contigmap]
label: popins2_contigmap
doc: "Align the reads with low-quality alignments of a sample to the supercontigs with BWA-MEM and merge the result with the sample's non_ref.bam into non_ref_new.bam.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
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
  - id: best
    type:
      - 'null'
      - boolean
    doc: "Do not use BWA-mem's -a option to output all alignments of a read"
    inputBinding:
      position: 1
      prefix: --best
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: "The maximum expected insert size of the read pairs. Default: 800"
    inputBinding:
      position: 1
      prefix: --maxInsertSize
  - id: no_non_ref_new
    type:
      - 'null'
      - boolean
    doc: "Delete the non_ref_new.bam file after writing locations"
    inputBinding:
      position: 1
      prefix: --noNonRefNew
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for BWA and samtools sort. Default: 1"
    inputBinding:
      position: 1
      prefix: --threads
  - id: memory
    type:
      - 'null'
      - string
    doc: "Maximum memory per thread for samtools sort; suffix K/M/G recognized. Default: 768M"
    inputBinding:
      position: 1
      prefix: --memory
  - id: sample_id
    type: string
    doc: "Sample ID (name of the sample folder)"
    inputBinding:
      position: 100
  - id: sample_dir
    type: Directory
    doc: "Sample folder written by popins2 assemble (non_ref.bam, ...)"
outputs:
  - id: sample_dir_out
    type: Directory
    doc: "Sample folder with non_ref_new.bam (+ index) and locations.txt"
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_contigmap.log
