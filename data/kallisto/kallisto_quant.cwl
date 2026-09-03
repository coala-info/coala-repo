cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - quant
label: kallisto_quant
doc: Computes equivalence classes for reads and quantifies abundances
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: FASTQ files to be quantified
    inputBinding:
      position: 1
  - id: index
    type:
      - 'null'
      - File
    doc: Filename for the kallisto index to be used for quantification
    inputBinding:
      position: 102
      prefix: --index
  - id: output_dir
    type: string
    doc: Directory to write output to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples
    inputBinding:
      position: 102
      prefix: --bootstrap-samples
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the bootstrap sampling
    inputBinding:
      position: 102
      prefix: --seed
  - id: plaintext
    type:
      - 'null'
      - boolean
    doc: Output plaintext instead of HDF5
    inputBinding:
      position: 102
      prefix: --plaintext
  - id: single
    type:
      - 'null'
      - boolean
    doc: Quantify single-end reads
    inputBinding:
      position: 102
      prefix: --single
  - id: single_overhang
    type:
      - 'null'
      - boolean
    doc: Include reads where unobserved rest of fragment is predicted to lie 
      outside a transcript
    inputBinding:
      position: 102
      prefix: --single-overhang
  - id: fr_stranded
    type:
      - 'null'
      - boolean
    doc: Strand specific reads, first read forward
    inputBinding:
      position: 102
      prefix: --fr-stranded
  - id: rf_stranded
    type:
      - 'null'
      - boolean
    doc: Strand specific reads, first read reverse
    inputBinding:
      position: 102
      prefix: --rf-stranded
  - id: fragment_length
    type:
      - 'null'
      - float
    doc: Estimated average fragment length
    inputBinding:
      position: 102
      prefix: --fragment-length
  - id: sd
    type:
      - 'null'
      - float
    doc: Estimated standard deviation of fragment length
    inputBinding:
      position: 102
      prefix: --sd
  - id: priors
    type:
      - 'null'
      - boolean
    doc: Priors for the EM algorithm, either as raw counts or as probabilities
    inputBinding:
      position: 102
      prefix: --priors
  - id: pseudobam
    type:
      - 'null'
      - boolean
    doc: Save pseudoalignments to transcriptome to BAM file
    inputBinding:
      position: 102
      prefix: --pseudobam
  - id: genomebam
    type:
      - 'null'
      - boolean
    doc: Project pseudoalignments to genome sorted BAM file
    inputBinding:
      position: 102
      prefix: --genomebam
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file for transcriptome information (required for --genomebam)
    inputBinding:
      position: 102
      prefix: --gtf
  - id: chromosomes
    type:
      - 'null'
      - File
    doc: Tab separated file with chromosome names and lengths (optional for 
      --genomebam, but recommended)
    inputBinding:
      position: 102
      prefix: --chromosomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write output to
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
s:url: https://pachterlab.github.io/kallisto
$namespaces:
  s: https://schema.org/
