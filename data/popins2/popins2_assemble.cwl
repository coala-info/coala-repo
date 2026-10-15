cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, assemble]
label: popins2_assemble
doc: "Filter, clip and assemble unmapped reads of a sample (reads without a high-quality alignment are quality-filtered with sickle and assembled with Minia by default).\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Path to the sample directories. Default: '.' (the working directory, where the sample folders are staged)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: sample
    type:
      - 'null'
      - string
    doc: "An ID for the sample. Default: retrieval from the BAM file header"
    inputBinding:
      position: 1
      prefix: --sample
  - id: adapters
    type:
      - 'null'
      - string
    doc: "Enable adapter removal for Illumina reads: HiSeq or HiSeqX. Default: no adapter removal"
    inputBinding:
      position: 1
      prefix: --adapters
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".bwt"
      - ".pac"
      - ".sa"
    doc: "Remap reads to this reference (bwa indexed) before assembly. Default: no remapping"
    inputBinding:
      position: 1
      prefix: --reference
  - id: filter
    type:
      - 'null'
      - int
    doc: "Treat reads aligned to all but the first INT reference sequences after remapping as high-quality aligned even if their alignment quality is low. Recommended for non-human reference sequences"
    inputBinding:
      position: 1
      prefix: --filter
  - id: use_velvet
    type:
      - 'null'
      - boolean
    doc: "Use the velvet assembler. Default: Minia"
    inputBinding:
      position: 1
      prefix: --use-velvet
  - id: use_spades
    type:
      - 'null'
      - boolean
    doc: "Use the SPAdes assembler. Default: Minia"
    inputBinding:
      position: 1
      prefix: --use-spades
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: "Skip assembly per sample"
    inputBinding:
      position: 1
      prefix: --skip-assembly
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "The k-mer size if the velvet assembler is used. Default: 47"
    inputBinding:
      position: 1
      prefix: --kmerLength
  - id: alignment_score_factor
    type:
      - 'null'
      - float
    doc: "A record is considered low quality if the alignment score (AS) is below FLOAT*read length. In range [0.0..1.0]. Default: 0.67"
    inputBinding:
      position: 1
      prefix: --alignment-score-factor
  - id: mate_pair
    type:
      - 'null'
      - File
    doc: "Mate-pair BAM file (currently only available for Velvet)"
    inputBinding:
      position: 1
      prefix: --matePair
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
  - id: bam_file
    type: File
    secondaryFiles:
      - ".bai"
    doc: "Input BAM file with reads of the sample (indexed); staged in the working directory, because popins2 records its path in the sample folder (POPINS_SAMPLE_INFO)"
    inputBinding:
      position: 100
      valueFrom: "$(self.basename)"
outputs:
  - id: sample_dir_out
    type:
      - 'null'
      - Directory
    doc: "Sample folder with the filtered reads, non_ref.bam and the assembly (assembly_final.contigs.fa)"
    outputBinding:
      glob: "$(inputs.sample)"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_assemble.log
