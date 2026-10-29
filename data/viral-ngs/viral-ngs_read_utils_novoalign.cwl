cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - novoalign
label: viral-ngs_read_utils_novoalign
doc: "Align reads with Novoalign. Sort and index BAM output.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input reads, BAM format."
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    secondaryFiles:
      - pattern: ^.nix
        required: true
    doc: "Reference genome, FASTA format, pre-indexed by Novoindex (the .nix index, named like the fasta without its extension, must be beside it)."
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    doc: "Output reads, BAM format (aligned)."
    inputBinding:
      position: 3
  - id: options
    type:
      - 'null'
      - string
    doc: "Novoalign options (default: -r Random)"
    inputBinding:
      position: 20
      prefix: --options
  - id: min_qual
    type:
      - 'null'
      - int
    doc: "Filter outBam to minimum mapping quality (default: 0)"
    inputBinding:
      position: 20
      prefix: --min_qual
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: novoalign_license_path
    type:
      - 'null'
      - File
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
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_bam_file
    type: File
    doc: "Aligned bam file"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: out_bai
    type:
      - 'null'
      - File
    doc: "Bam index, if written"
    outputBinding:
      glob: $(inputs.out_bam).bai
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_novoalign.out
