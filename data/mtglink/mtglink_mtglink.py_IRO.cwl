cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mtglink.py, IRO]
label: mtglink_mtglink.py_IRO
doc: "Local assembly with linked reads using an Iterative Read Overlap (IRO) algorithm\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: gfa
    type: File
    doc: "Input GFA file (GFA 2.0) (format: xxx.gfa)"
    inputBinding:
      prefix: -gfa
      valueFrom: $(self.basename)
  - id: flanking_fastas
    type: File[]
    doc: "FASTA files with the flanking sequences named in the GFA (UR tags); staged beside the GFA"
  - id: bam
    type: File
    doc: "BAM file: linked-reads mapped on reference genome (format: xxx.bam)"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      prefix: -bam
  - id: reads
    type: File
    doc: "File (gzipped) of indexed reads (format: xxx.fastq.gz | xxx.fq.gz)"
    inputBinding:
      prefix: -fastq
      valueFrom: $(self.basename)
  - id: gzip_index
    type: File
    doc: "BGZF block index (.gzi) of the gzipped reads, written by LRez index fastq; staged beside the reads"
  - id: index
    type: File
    doc: "Barcodes index file (format: xxx.bci)"
    inputBinding:
      prefix: -index
  - id: outdir
    type: string
    doc: "Output directory [default: ./MTG-Link_results]"
    default: MTG-Link_results
    inputBinding:
      prefix: -out
  - id: line
    type: ['null', int]
    doc: "Line of GFA file input from which to start analysis (default: first line)"
    inputBinding:
      prefix: -line
  - id: bxu_dir
    type: ['null', Directory]
    doc: "Directory where the FASTQ files containing the subsample of reads are located (to provide if the read subsampling step has already been done)"
    inputBinding:
      prefix: -bxuDir
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for the Read Subsampling step [default: 1]"
    inputBinding:
      prefix: -t
  - id: flank_size
    type: ['null', int]
    doc: "Flanking sequences' size (bp) [default: 10000]"
    inputBinding:
      prefix: -flank
  - id: min_barcode_occ
    type: ['null', int]
    doc: "Minimum number of occurrences in target flanking regions for a barcode to be retained in the union set [default: 2]"
    inputBinding:
      prefix: -occ
  - id: ext_size
    type: ['null', int]
    doc: "Size of the extension of the target on both sides (bp); determine start/end of local assembly [default: 500]"
    inputBinding:
      prefix: -ext
  - id: max_length
    type: ['null', int]
    doc: "Maximum assembly length (bp) [default: 10000]"
    inputBinding:
      prefix: -l
  - id: seed_size
    type: ['null', int]
    doc: "Seed size used for indexing the reads (bp) [default: 10]"
    inputBinding:
      prefix: -s
  - id: min_overlap
    type: ['null', int]
    doc: "Minimum overlapping size (bp) [default: 20]"
    inputBinding:
      prefix: -o
  - id: abundance_min
    type:
      - 'null'
      - type: array
        items: int
    doc: "Minimal abundance(s) of reads used for local assembly [default: 3 2]"
    inputBinding:
      prefix: -a
      separate: true
  - id: max_score
    type: ['null', int]
    doc: "Maximum number of gaps/substitutions allowed in the inexact overlap between reads [default: 2]"
    inputBinding:
      prefix: -dmax
outputs:
  - id: results_dir
    type: Directory
    doc: Output directory with the assembled sequences and the output GFA file
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gfa)
      - $(inputs.flanking_fastas)
      - entryname: $(inputs.reads.basename)
        entry: $(inputs.reads)
        writable: true
      - entryname: $(inputs.reads.nameroot).gzi
        entry: $(inputs.gzip_index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
