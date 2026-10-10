cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - blobology
label: metawrap_blobology
doc: "Run blobology on assembly and reads\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "Read files named name_1.fastq and name_2.fastq, one pair per sample"
    inputBinding:
      position: 200
      valueFrom: $(self.map(function (f) { return f.basename; }))
  - id: assembly_fasta
    type: File
    doc: assembly fasta file
    inputBinding:
      position: 104
      prefix: -a
  - id: bins
    type:
      - 'null'
      - Directory
    doc: Folder containing bins. Contig names must match those of the assembly 
      file.
    inputBinding:
      position: 104
      prefix: --bins
  - id: output_dir
    type: string
    doc: output directory
    inputBinding:
      position: 104
      prefix: -o
  - id: subsample
    type:
      - 'null'
      - int
    doc: Number of contigs to run blobology on. Subsampling is randomized.
    inputBinding:
      position: 104
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap_blobology.out
