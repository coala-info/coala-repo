cwlVersion: v1.2
class: CommandLineTool
baseCommand: [qsignature, org.qcmg.sig.SignatureGenerator]
label: qsignature_SignatureGenerator
doc: "Generate a qsignature VCF of base counts at SNP positions from a BAM file.\n\nTool homepage: https://github.com/AdamaJava/adamajava/tree/master/qsignature"
inputs:
  - id: input
    type: File
    doc: "Input BAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 1
      prefix: -i
  - id: outdir
    type: string
    doc: "Specifies the output directory."
    inputBinding:
      position: 1
      prefix: -d
  - id: snp_positions
    type: File
    doc: "Specifies the snp positions file."
    inputBinding:
      position: 1
      prefix: --snpPositions
  - id: illumina_arrays_design
    type:
      - 'null'
      - File
    doc: "Illumina Arrays Design file."
    inputBinding:
      position: 1
      prefix: --illuminaArraysDesign
  - id: log
    type: string
    doc: "Full path to file where log output will be directed."
    inputBinding:
      position: 1
      prefix: --log
  - id: loglevel
    type:
      - 'null'
      - string
    doc: "Logging level required, e.g. INFO, DEBUG."
    inputBinding:
      position: 1
      prefix: --loglevel
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: "Minimum base quality the base must have to be considered in the calculation."
    inputBinding:
      position: 1
      prefix: --minBaseQuality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality the read must have to be considered in the calculation."
    inputBinding:
      position: 1
      prefix: --minMappingQuality
  - id: no_of_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to be used when retrieving positions from bam files."
    inputBinding:
      position: 1
      prefix: --noOfThreads
  - id: validation
    type:
      - 'null'
      - string
    doc: "How strict to be when reading a SAM or BAM: STRICT, LENIENT or SILENT."
    inputBinding:
      position: 1
      prefix: --validation
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: "Specifies that bam access should be sequential rather than indexed."
    inputBinding:
      position: 1
      prefix: --sequential
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
  - class: InlineJavascriptRequirement
outputs:
  - id: signature_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: "Signature VCF files (.qsig.vcf.gz)"
    outputBinding:
      glob: $(inputs.outdir)/*.qsig.vcf*
  - id: log_file
    type: File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qsignature:0.1pre--3
