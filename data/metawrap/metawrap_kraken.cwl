cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - kraken
label: metawrap_kraken
doc: "Run on any number of fasta assembly files and/or or paired-end reads.\n\nTool
  homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "Sequence files: assembly files (*.fa, *.fasta) and/or paired reads named name_1.fastq and name_2.fastq"
    inputBinding:
      position: 200
      valueFrom: $(self.map(function (f) { return f.basename; }))
  - id: no_preload
    type:
      - 'null'
      - boolean
    doc: do not pre-load the kraken DB into memory (slower, but lower memory 
      requirement)
    inputBinding:
      position: 104
      prefix: --no-preload
  - id: output_dir
    type: string
    doc: output directory
    inputBinding:
      position: 104
      prefix: -o
  - id: read_subsampling
    type:
      - 'null'
      - int
    doc: read subsampling number
    inputBinding:
      position: 104
      prefix: -s
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
stdout: metawrap_kraken.out
