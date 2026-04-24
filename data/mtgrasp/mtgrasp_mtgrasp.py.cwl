cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtgrasp.py
label: mtgrasp_mtgrasp.py
doc: "de novo assembly of reference-grade animal mitochondrial genomes\n\nTool homepage:
  https://github.com/bcgsc/mtGrasp"
inputs:
  - id: abyss_fpr
    type:
      - 'null'
      - float
    doc: False positive rate for the Bloom filter used by ABySS
    inputBinding:
      position: 101
      prefix: --abyss_fpr
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Run gene annotation on the final assembly output
    inputBinding:
      position: 101
      prefix: --annotate
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete intermediate subdirectories/files once mtGrasp reaches 
      completion
    inputBinding:
      position: 101
      prefix: --delete
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry-run pipeline
    inputBinding:
      position: 101
      prefix: --dry_run
  - id: end_recov_p
    type:
      - 'null'
      - int
    doc: Merge at most N alternate paths during Sealer flanking end recovery
    inputBinding:
      position: 101
      prefix: --end_recov_p
  - id: end_recov_sealer_fpr
    type:
      - 'null'
      - float
    doc: False positive rate for the Bloom filter used by Sealer during flanking
      end recovery
    inputBinding:
      position: 101
      prefix: --end_recov_sealer_fpr
  - id: end_recov_sealer_k
    type:
      - 'null'
      - string
    doc: k-mer size used in Sealer flanking end recovery
    inputBinding:
      position: 101
      prefix: --end_recov_sealer_k
  - id: gap_filling_p
    type:
      - 'null'
      - int
    doc: Merge at most N alternate paths during sealer gap filling step
    inputBinding:
      position: 101
      prefix: --gap_filling_p
  - id: kc
    type:
      - 'null'
      - int
    doc: minimum k-mer multiplicity for ABySS
    inputBinding:
      position: 101
      prefix: --kc
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size used in ABySS de novo assembly
    inputBinding:
      position: 101
      prefix: --kmer
  - id: mismatch_allowed
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed in overlaps between the two ends 
      of the mitochondrial assembly
    inputBinding:
      position: 101
      prefix: --mismatch_allowed
  - id: mitos_path
    type:
      - 'null'
      - File
    doc: Complete path to runmitos.py
    inputBinding:
      position: 101
      prefix: --mitos_path
  - id: mt_gen
    type: string
    doc: Mitochondrial genetic code
    inputBinding:
      position: 101
      prefix: --mt_gen
  - id: nosubsample
    type:
      - 'null'
      - boolean
    doc: Run mtGrasp using the entire read dataset without subsampling
    inputBinding:
      position: 101
      prefix: --nosubsample
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: read1
    type: File
    doc: Full path to forward read fastq.gz file
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Full path to reverse read fastq.gz file
    inputBinding:
      position: 101
      prefix: --read2
  - id: ref_path
    type: File
    doc: Full path to the reference fasta file
    inputBinding:
      position: 101
      prefix: --ref_path
  - id: sealer_fpr
    type:
      - 'null'
      - float
    doc: False positive rate for the Bloom filter used by Sealer during gap 
      filling
    inputBinding:
      position: 101
      prefix: --sealer_fpr
  - id: sealer_k
    type:
      - 'null'
      - string
    doc: k-mer size used in sealer gap filling
    inputBinding:
      position: 101
      prefix: --sealer_k
  - id: subsample
    type:
      - 'null'
      - int
    doc: Subsample N read pairs from two paired FASTQ files
    inputBinding:
      position: 101
      prefix: --subsample
  - id: test_run
    type:
      - 'null'
      - boolean
    doc: Test run mtGrasp to ensure all required dependencies are installed
    inputBinding:
      position: 101
      prefix: --test_run
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Remove a lock implemented by snakemake on the working directory
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
stdout: mtgrasp_mtgrasp.py.out
