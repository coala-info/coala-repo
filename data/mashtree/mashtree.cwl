cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashtree
label: mashtree
doc: "use distances from Mash (min-hash algorithm) to make a NJ tree\n\nTool homepage:
  https://github.com/lskatz/mashtree"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files (*.fastq, *.fasta, *.gbk, *.msh). fastq files are read as 
      raw reads; fasta, gbk, and embl files are read as assemblies; Input files 
      can be gzipped.
    inputBinding:
      position: 1
  - id: file_of_files
    type:
      - 'null'
      - boolean
    doc: If specified, mashtree will try to read filenames from each input file.
      The file of files format is one filename per line. This file of files 
      cannot be compressed.
    inputBinding:
      position: 102
      prefix: --file-of-files
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Genome size for mash sketch
    inputBinding:
      position: 102
      prefix: --genomesize
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length for mash sketch
    inputBinding:
      position: 102
      prefix: --kmerlength
  - id: mindepth
    type:
      - 'null'
      - int
    doc: If mindepth is zero, then it will be chosen in a smart but slower 
      method, to discard lower-abundance kmers.
    inputBinding:
      position: 102
      prefix: --mindepth
  - id: numcpus
    type:
      - 'null'
      - int
    doc: This script uses Perl threads.
    inputBinding:
      position: 102
      prefix: --numcpus
  - id: save_sketches
    type:
      - 'null'
      - Directory
    doc: If a directory is supplied, then sketches will be saved in it.
    inputBinding:
      position: 102
      prefix: --save-sketches
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for mash sketch
    inputBinding:
      position: 102
      prefix: --seed
  - id: sigfigs
    type:
      - 'null'
      - int
    doc: How many decimal places to use in mash distances
    inputBinding:
      position: 102
      prefix: --sigfigs
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size for mash
    inputBinding:
      position: 102
      prefix: --sketch-size
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'For neighbor-joining, the sort order can make a difference. Options include:
      ABC (alphabetical), random, input-order'
    inputBinding:
      position: 102
      prefix: --sort-order
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: If specified, this directory will not be removed at the end of the 
      script and can be used to cache results for future analyses.
      script
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: trunc_length
    type:
      - 'null'
      - int
    doc: How many characters to keep in a filename
    inputBinding:
      position: 102
      prefix: --truncLength
outputs:
  - id: outmatrix
    type:
      - 'null'
      - File
    doc: If specified, will write a distance matrix in tab-delimited format
    outputBinding:
      glob: $(inputs.outmatrix)
  - id: outtree
    type:
      - 'null'
      - File
    doc: If specified, the tree will be written to this file and not to stdout. 
      Log messages will still go to stderr.
    outputBinding:
      glob: $(inputs.outtree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3
