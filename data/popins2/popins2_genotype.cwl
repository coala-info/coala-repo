cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, genotype]
label: popins2_genotype
doc: "Genotype a sample for the insertions in a VCF file: reads are aligned to the reference and the alternative insertion sequence; genotype likelihoods (GT:PL) are written to insertions.vcf in the sample folder.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Path to the sample directories. Default: '.' (the working directory, where the sample folders are staged)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: insertions
    type:
      - 'null'
      - string
    doc: "Name of the VCF input file (staged in the working directory). Default: insertions.vcf"
    inputBinding:
      position: 1
      prefix: --insertions
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
  - id: model
    type:
      - 'null'
      - string
    doc: "Model used for genotyping: DUP or RANDOM. Default: RANDOM"
    inputBinding:
      position: 1
      prefix: --model
  - id: window
    type:
      - 'null'
      - int
    doc: "Region window size. Default: 50"
    inputBinding:
      position: 1
      prefix: --window
  - id: add_read_group
    type:
      - 'null'
      - boolean
    doc: "Add read group"
    inputBinding:
      position: 1
      prefix: --addReadGroup
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: "Maximum read pair insert size. Default: 500"
    inputBinding:
      position: 1
      prefix: --maxInsertSize
  - id: qual
    type:
      - 'null'
      - int
    doc: "Quality score threshold for read trimming. Default: 0"
    inputBinding:
      position: 1
      prefix: --qual
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: "Minimum read length after trimming"
    inputBinding:
      position: 1
      prefix: --minSeqLen
  - id: min_read_prob
    type:
      - 'null'
      - float
    doc: "Minimum read probability. Default: 1e-05"
    inputBinding:
      position: 1
      prefix: --minReadProb
  - id: max_read_count
    type:
      - 'null'
      - int
    doc: "Maximum number of reads to consider in region window. Default: 200"
    inputBinding:
      position: 1
      prefix: --maxReadCount
  - id: match
    type:
      - 'null'
      - int
    doc: "Cost of match. Default: 1"
    inputBinding:
      position: 1
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: "Cost of mismatch. Default: -2"
    inputBinding:
      position: 1
      prefix: --mismatch
  - id: gap_open
    type:
      - 'null'
      - int
    doc: "Cost of gap open. Default: -4"
    inputBinding:
      position: 1
      prefix: --gapOpen
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: "Cost of gap extend. Default: -1"
    inputBinding:
      position: 1
      prefix: --gapExtend
  - id: min_score
    type:
      - 'null'
      - int
    doc: "Minimum alignment score. Default: 55"
    inputBinding:
      position: 1
      prefix: --minScore
  - id: insertions_vcf
    type: File
    doc: "Insertion VCF from popins2 place-finish; staged in the working directory under the name given by insertions"
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
    doc: "Sample folder (non_ref_new.bam and reads of the sample)"
outputs:
  - id: sample_dir_out
    type: Directory
    doc: "Sample folder with insertions.vcf holding the genotypes of the sample"
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
      - entryname: $(inputs.insertions || 'insertions.vcf')
        entry: $(inputs.insertions_vcf)
      - $(inputs.reference)
      - $(inputs.contigs)
      - $(inputs.bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_genotype.log
