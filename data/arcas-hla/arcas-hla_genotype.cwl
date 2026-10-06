cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - arcasHLA
  - genotype
label: arcas-hla_genotype
doc: "Type HLA genes from extracted reads (FASTQ) or an alignment.p file. Needs the IMGT/HLA reference built with 'arcasHLA reference' inside the arcasHLA install folder.\n\nTool homepage: https://github.com/RabadanLab/arcasHLA"
inputs:
  - id: file
    type: File[]
    doc: list of fastq files (e.g. sample.extracted.fq.gz) or alignment file (sample.alignment.p)
    inputBinding:
      position: 10
  - id: log
    type:
      - 'null'
      - string
    doc: "log file for run summary (default: sample.<command>.log in the out directory)"
    inputBinding:
      position: 1
      prefix: --log
  - id: genes
    type:
      - 'null'
      - string
    doc: "comma separated list of HLA genes (default: all; options: A, B, C, DMA, DMB, DOA, DOB, DPA1, DPB1, DQA1, DQB1, DRA, DRB1, DRB3, DRB5, E, F, G, H, J, K, L)"
    inputBinding:
      position: 1
      prefix: --genes
  - id: population
    type:
      - 'null'
      - string
    doc: "sample population (default: prior; options: asian_pacific_islander, black, caucasian, hispanic, native_american, prior)"
    inputBinding:
      position: 1
      prefix: --population
  - id: tolerance
    type:
      - 'null'
      - float
    doc: "convergence tolerance (default: 10e-7)"
    inputBinding:
      position: 1
      prefix: --tolerance
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: "maximum # of iterations (default: 1000)"
    inputBinding:
      position: 1
      prefix: --max_iterations
  - id: drop_iterations
    type:
      - 'null'
      - int
    doc: "EM iteration to start dropping low-support alleles"
    inputBinding:
      position: 1
      prefix: --drop_iterations
  - id: drop_threshold
    type:
      - 'null'
      - float
    doc: "proportion of max abundance allele needs to not be dropped (default: 0.1)"
    inputBinding:
      position: 1
      prefix: --drop_threshold
  - id: zygosity_threshold
    type:
      - 'null'
      - float
    doc: "proportion of major allele abundance needed to be considered heterozygous (default: 0.1)"
    inputBinding:
      position: 1
      prefix: --zygosity_threshold
  - id: min_count
    type:
      - 'null'
      - int
    doc: "minimum gene read count required for genotyping (default: 75)"
    inputBinding:
      position: 1
      prefix: --min_count
  - id: outdir
    type: string
    doc: out directory
    default: genotype
    inputBinding:
      position: 1
      prefix: --outdir
  - id: temp
    type:
      - 'null'
      - string
    doc: "temp directory"
    inputBinding:
      position: 1
      prefix: --temp
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: "keep intermediate files"
    inputBinding:
      position: 1
      prefix: --keep_files
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose output"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: avg
    type:
      - 'null'
      - int
    doc: "Estimated average fragment length for single-end reads (default: 200)"
    inputBinding:
      position: 1
      prefix: --avg
  - id: std
    type:
      - 'null'
      - int
    doc: "Estimated standard deviation of fragment length for single-end reads (default: 20)"
    inputBinding:
      position: 1
      prefix: --std
  - id: single
    type:
      - 'null'
      - boolean
    doc: "Include flag if single-end reads. Default is paired-end."
    inputBinding:
      position: 1
      prefix: --single
outputs:
  - id: genotype_json
    type: File
    doc: HLA genotype calls (sample.genotype.json)
    outputBinding:
      glob: $(inputs.outdir)/*.genotype.json
  - id: out_dir
    type: Directory
    doc: Out directory with the genotype, log and intermediate files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
