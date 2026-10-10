cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - quant_bins
label: metawrap_quant_bins
doc: "Quantify abundance of bins in metagenomic datasets\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "Read files named name_1.fastq and name_2.fastq, one pair per sample; staged into one folder because metaWRAP derives the mate path from the first file"
    inputBinding:
      position: 200
      valueFrom: $(self.map(function (f) { return f.basename; }))
  - id: assembly_fa
    type: File
    doc: fasta file with entire metagenomic assembly (strongly recommended!)
    inputBinding:
      position: 104
      prefix: -a
  - id: bins_folder
    type: Directory
    doc: folder containing draft genomes (bins) in fasta format
    inputBinding:
      position: 104
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: output_dir_path
    type: string
    doc: output directory
    inputBinding:
      position: 105
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
