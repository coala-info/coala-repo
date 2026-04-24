cwlVersion: v1.2
class: CommandLineTool
baseCommand: whokaryote.py
label: whokaryote_whokaryote.py
doc: "Classify metagenomic contigs as eukaryotic or prokaryotic\n\nTool homepage:
  https://github.com/LottePronk/whokaryote"
inputs:
  - id: contigs
    type:
      - 'null'
      - File
    doc: The path to your contigs file. It should be one (multi)fasta (DNA).
    inputBinding:
      position: 101
      prefix: --contigs
  - id: gff
    type:
      - 'null'
      - File
    doc: If you already have gene predictions, specify path to the .gff file
    inputBinding:
      position: 101
      prefix: --gff
  - id: min_size
    type:
      - 'null'
      - int
    doc: Select a minimum contig size in bp, default = 5000. Accuracy on contigs
      below 5000 is lower.
    inputBinding:
      position: 101
      prefix: --minsize
  - id: model
    type:
      - 'null'
      - string
    doc: "Choose the stand-alone model or the tiara-integrated model: S or T. Option
      'T' only works with argument --contigs"
    inputBinding:
      position: 101
      prefix: --model
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Specify the path to your preferred output directory. No / at the end.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_separate_files
    type:
      - 'null'
      - boolean
    doc: If you want new multifastas with only eukaryotes and only prokaryotes.
    inputBinding:
      position: 101
      prefix: --f
  - id: test_dataset
    type:
      - 'null'
      - boolean
    doc: If you want to test it on a known dataset.
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for Tiara to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: train
    type:
      - 'null'
      - string
    doc: For training an RF on your own dataset. Provide name of RF output file.
    inputBinding:
      position: 101
      prefix: --train
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whokaryote:1.1.2--pyhdfd78af_0
stdout: whokaryote_whokaryote.py.out
