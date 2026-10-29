cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - align_and_fix
label: viral-ngs_read_utils_align_and_fix
doc: "Take reads, align to reference with Novoalign, mark duplicates with Picard, realign indels with GATK, and optionally filter final file to mapped/non-dupe reads.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: "Reference genome, FASTA format; will be indexed by Picard and Novoalign."
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: out_bam_all
    type:
      - 'null'
      - string
    doc: "Aligned, sorted, and indexed reads. Unmapped reads are retained and duplicate reads are marked, not removed."
    inputBinding:
      position: 20
      prefix: --outBamAll
  - id: out_bam_filtered
    type:
      - 'null'
      - string
    doc: "Aligned, sorted, and indexed reads. Unmapped reads and duplicate reads are removed from this file."
    inputBinding:
      position: 20
      prefix: --outBamFiltered
  - id: aligner_options
    type:
      - 'null'
      - string
    doc: "aligner options (default for novoalign: \"-r Random\", bwa: \"-T 30\""
    inputBinding:
      position: 20
      prefix: --aligner_options
  - id: aligner
    type:
      - 'null'
      - type: enum
        symbols:
          - novoalign
          - bwa
    doc: "aligner (default: novoalign)"
    inputBinding:
      position: 20
      prefix: --aligner
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 4g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 1)"
    inputBinding:
      position: 20
      prefix: --threads
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
  - id: out_bam_all_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_bam_all"
    outputBinding:
      glob: $(inputs.out_bam_all)
  - id: out_bam_filtered_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_bam_filtered"
    outputBinding:
      glob: $(inputs.out_bam_filtered)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_fasta)
        writable: true

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
