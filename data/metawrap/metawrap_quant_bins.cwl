cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap quant_bins
label: metawrap_quant_bins
doc: "Quantify abundance of bins in metagenomic datasets\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: readsA_1
    type: File
    doc: First read file for dataset A
    inputBinding:
      position: 1
  - id: readsA_2
    type:
      - 'null'
      - File
    doc: Second read file for dataset A
    inputBinding:
      position: 2
  - id: readsX
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional read files for other datasets (e.g., readsX_1.fastq 
      readsX_2.fastq)
    inputBinding:
      position: 3
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
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
