cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellsnp-lite
label: cellsnp-lite
doc: "A lightweight tool for efficient calling and genotyping of single nucleotide
  polymorphisms (SNPs) in single-cell RNA-seq data.\n\nTool homepage: https://github.com/single-cell-genetics/cellSNP"
inputs:
  - id: sam_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Indexed BAM/CRAM file(s), comma separated multiple samples.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .csi
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 101
      prefix: --samFile
      itemSeparator: ','
  - id: sam_file_list
    type:
      - 'null'
      - File
    doc: A file listing BAM/CRAM files, each per line.
    inputBinding:
      position: 101
      prefix: --samFileList
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM/CRAM files (with their indexes) named by sam_file_list. They are
      staged in the working directory, so the list can name them by base name.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .csi
        required: false
      - pattern: .crai
        required: false
  - id: out_dir
    type: string
    doc: Output directory for VCF and sparse matrices.
    inputBinding:
      position: 101
      prefix: --outDir
  - id: regions_vcf
    type:
      - 'null'
      - File
    doc: A vcf file listing all candidate SNPs, for fetch each variants.
    inputBinding:
      position: 101
      prefix: --regionsVCF
  - id: targets_vcf
    type:
      - 'null'
      - File
    doc: Similar as -R, but the next position is accessed by streaming rather
      than indexing/jumping (like -T in samtools/bcftools mpileup).
    inputBinding:
      position: 101
      prefix: --targetsVCF
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: A plain file listing all effective cell barcodes.
    inputBinding:
      position: 101
      prefix: --barcodeFile
  - id: sample_list
    type:
      - 'null'
      - File
    doc: A list file containing sample IDs, each per line.
    inputBinding:
      position: 101
      prefix: --sampleList
  - id: sample_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated sample IDs.
    inputBinding:
      position: 101
      prefix: --sampleIDs
      itemSeparator: ','
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: If use, do genotyping in addition to counting.
    inputBinding:
      position: 101
      prefix: --genotype
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: If use, the output files will be zipped into BGZF format.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: print_skip_snps
    type:
      - 'null'
      - boolean
    doc: If use, the SNPs skipped when loading VCF will be printed.
    inputBinding:
      position: 101
      prefix: --printSkipSNPs
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of threads [1]
    inputBinding:
      position: 101
      prefix: --nproc
  - id: refseq
    type:
      - 'null'
      - File
    doc: Faidx indexed reference sequence file. If set, the real (genomic) ref
      extracted from this file would be used for Mode 2 or for the missing REFs
      in the input VCF for Mode 1.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --refseq
  - id: chrom
    type:
      - 'null'
      - string
    doc: The chromosomes to use, comma separated [1 to 22]
    inputBinding:
      position: 101
      prefix: --chrom
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: Tag for cell barcodes, turn off with None [CB]
    inputBinding:
      position: 101
      prefix: --cellTAG
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: 'Tag for UMI: UB, Auto, None. For Auto mode, use UB if barcodes are inputted,
      otherwise use None. None mode means no UMI but read counts [Auto]'
    inputBinding:
      position: 101
      prefix: --UMItag
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum aggragated UMI or read count [20]
    inputBinding:
      position: 101
      prefix: --minCOUNT
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency [0.00]
    inputBinding:
      position: 101
      prefix: --minMAF
  - id: incl_flag
    type:
      - 'null'
      - string
    doc: 'Required flags: skip reads with all mask bits unset []'
    inputBinding:
      position: 101
      prefix: --inclFLAG
  - id: excl_flag
    type:
      - 'null'
      - string
    doc: 'Filter flags: skip reads with any mask bits set [UNMAP,SECONDARY,QCFAIL (when
      use UMI) or UNMAP,SECONDARY,QCFAIL,DUP (otherwise)]'
    inputBinding:
      position: 101
      prefix: --exclFLAG
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum mapped length for read filtering [30]
    inputBinding:
      position: 101
      prefix: --minLEN
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for read filtering [20]
    inputBinding:
      position: 101
      prefix: --minMAPQ
  - id: max_depth
    type:
      - 'null'
      - int
    doc: At a position, read maximally INT reads per input file, to avoid
      excessive memory usage; 0 means highest possible value [0]
    inputBinding:
      position: 101
      prefix: --maxDEPTH
  - id: count_orphan
    type:
      - 'null'
      - boolean
    doc: If use, do not skip anomalous read pairs.
    inputBinding:
      position: 101
      prefix: --countORPHAN
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for VCF and sparse matrices.
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.listed_files ? inputs.listed_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellsnp-lite:1.2.3--ha0c3a46_6
