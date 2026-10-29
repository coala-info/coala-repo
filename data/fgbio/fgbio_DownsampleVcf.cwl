cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_DownsampleVcf
doc: "Re-genotypes a VCF after downsampling the allele counts.\n\nThe input VCF must\
  \ have at least one sample.\n\nIf the input VCF contains a single sample, the downsampling\
  \ target may be specified as a proportion of the original\nread depth using '--proportion=(0..1)',\
  \ or as the combination of the original and target number of sequenced bases\n('--originalBases'\
  \ and '--downsampleToBases'). For multi-sample VCFs, the downsampling target must\
  \ be specified using\n'--downsampleToBases', and a metadata file with the total\
  \ number of sequenced bases per sample is required as well. The\nmetadata file must\
  \ follow the [https://www.internationalgenome.org/category/meta-data/ 1000 Genomes\
  \ index format], but\nthe only required columns are 'SAMPLE_NAME' and 'BASE_COUNT'.\
  \ A propportion for each sample is calculated by dividing\nthe target number of\
  \ sequenced bases by the original number of sequenced bases.\n\nThe tool first (optionally)\
  \ winnows the VCF file to remove variants within a distance to each other specified\
  \ by\n'--window-size' (the default value of '0' disables winnowing). Next, each\
  \ sample at each variant is examined\nindependently. The allele depths per-genotype\
  \ are randoml downsampled given the proportion. The downsampled allele\ndepths are\
  \ then used to re-compute allele likelhoods and produce a new genotype. In the event\
  \ that the downsampled\nallele depth is below minAdHomref (for HOMREF calls) or\
  \ minAdHomvar (for HOMVAR calls), the new genotype will be set to\nNOCALL. minAdHomvar\
  \ has a default value of 3 to prevent downsampled VCFs from having an excess proportion\
  \ of HOMVAR\ncalls (that a variant caller would likely not call on such weak evidence).\
  \ minAdHomref has a default value of 1 (i.e.\nno HOMREF calls are rejected).\n\n\
  The tool outputs a downsampled VCF file with the winnowed variants removed, and\
  \ with the genotype calls and 'DP', 'AD',\nand 'PL' tags updated for each sample\
  \ at each retained variant.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: downsample_to_bases
    type:
      - 'null'
      - double
    doc: Target number of bases to downsample to.
    inputBinding:
      position: 101
      prefix: --downsample-to-bases
  - id: epsilon
    type:
      - 'null'
      - double
    doc: 'Sequencing Error rate for genotyping. [Default: 0.01].'
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: input_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: The vcf to downsample.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: metadata
    type:
      - 'null'
      - File
    doc: Index file with bases per sample.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_ad_homref
    type:
      - 'null'
      - int
    doc: 'Minimum allele depth to call HOMREF (otherwise NO-CALL) [Default: 1].'
    inputBinding:
      position: 101
      prefix: --min-ad-homref
  - id: min_ad_homvar
    type:
      - 'null'
      - int
    doc: 'Minimum allele depth to call HOMVAR (otherwise NO-CALL) [Default: 3].'
    inputBinding:
      position: 101
      prefix: --min-ad-homvar
  - id: original_bases
    type:
      - 'null'
      - double
    doc: Original number of bases (for single-sample VCF).
    inputBinding:
      position: 101
      prefix: --original-bases
  - id: output_vcf
    type: string
    doc: Output file name.
    inputBinding:
      position: 101
      prefix: --output
  - id: proportion
    type:
      - 'null'
      - double
    doc: Proportion of bases to retain (for single-sample VCF).
    inputBinding:
      position: 101
      prefix: --proportion
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed value. [Default: 42].'
    inputBinding:
      position: 101
      prefix: --seed
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Winnowing window size. [Default: 0].'
    inputBinding:
      position: 101
      prefix: --window-size
  - id: write_no_call
    type:
      - 'null'
      - boolean
    doc: 'True to write out no-calls. [Default: false].'
    inputBinding:
      position: 101
      prefix: --write-no-call
      separate: false
      valueFrom: $("=" + self)
arguments:
  - position: 50
    valueFrom: DownsampleVcf
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF file.
    outputBinding:
      glob: $(inputs.output_vcf)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
