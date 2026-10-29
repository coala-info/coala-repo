cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - refine_assembly
label: viral-ngs_assembly_refine_assembly
doc: "This a refinement step where we take a crude assembly, align all reads back to it, and modify the assembly to the majority allele at each position based on read pileups. This step considers both SNPs as well as indels called by GATK and will correct the consensus based on GATK calls. Reads are aligned with Novoalign, then PCR duplicates are removed with Picard (in order to debias the allele counts in the pileups), and realigned with GATK's IndelRealigner (in order to call indels). Output FASTA file is indexed for Picard, Samtools, and Novoalign.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Input assembly, FASTA format, pre-indexed for Picard, Samtools, and Novoalign."
    inputBinding:
      position: 1
  - id: in_bam
    type: File
    doc: "Input reads, unaligned BAM format."
    inputBinding:
      position: 2
  - id: out_fasta
    type: string
    doc: "Output refined assembly, FASTA format, indexed for Picard, Samtools, and Novoalign."
    inputBinding:
      position: 3
  - id: already_realigned_bam
    type:
      - 'null'
      - File
    doc: "BAM with reads that are already aligned to inFasta. This bypasses the alignment process by novoalign and instead uses the given BAM to make an assembly. When set, outBam is ignored."
    inputBinding:
      position: 20
      prefix: --already_realigned_bam
  - id: out_bam
    type:
      - 'null'
      - string
    doc: "Reads aligned to inFasta. Unaligned and duplicate reads have been removed. GATK indel realigned."
    inputBinding:
      position: 20
      prefix: --outBam
  - id: out_vcf
    type:
      - 'null'
      - string
    doc: "GATK genotype calls for genome in inFasta coordinate space."
    inputBinding:
      position: 20
      prefix: --outVcf
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "Minimum read coverage required to call a position unambiguous."
    inputBinding:
      position: 20
      prefix: --min_coverage
  - id: major_cutoff
    type:
      - 'null'
      - float
    doc: "If the major allele is present at a frequency higher than this cutoff, we will call an unambiguous base at that position. If it is equal to or below this cutoff, we will call an ambiguous base representing all possible alleles at that position. [default: 0.5]"
    inputBinding:
      position: 20
      prefix: --major_cutoff
  - id: novo_params
    type:
      - 'null'
      - string
    doc: "Alignment parameters for Novoalign."
    inputBinding:
      position: 20
      prefix: --novo_params
  - id: chr_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Rename all output chromosomes (default: retain original chromosome names)"
    inputBinding:
      position: 30
      prefix: --chr_names
  - id: keep_all_reads
    type:
      - 'null'
      - boolean
    doc: "Retain all reads in BAM file? Default is to remove unaligned and duplicate reads."
    inputBinding:
      position: 20
      prefix: --keep_all_reads
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: gatk_path
    type:
      - 'null'
      - string
    doc: "A path containing the GATK jar file. This overrides the GATK_ENV environment variable or the GATK conda package. (default: None)"
    inputBinding:
      position: 20
      prefix: --GATK_PATH
  - id: novoalign_license_path
    type:
      - 'null'
      - string
    doc: "A path to the novoalign.lic file. This overrides the NOVOALIGN_LICENSE_PATH environment variable. (default: None)"
    inputBinding:
      position: 20
      prefix: --NOVOALIGN_LICENSE_PATH
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 1)"
    inputBinding:
      position: 20
      prefix: --threads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_fasta_file
    type: File
    doc: "Output file written to out_fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_bam_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_bam"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: out_vcf_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_vcf"
    outputBinding:
      glob: $(inputs.out_vcf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
