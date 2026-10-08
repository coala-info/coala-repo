cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - geno2phenotb
  - run
label: geno2phenotb_run
doc: "Run the geno2phenotb pipeline.\n\nTool homepage: https://github.com/msmdev/geno2phenoTB"
inputs:
  - id: drug
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --drug
    doc: The drug for which resistance should be predicted. If you want 
      predictions for several drugs, use the argument several times,i.e., -d AMK
      -d DCS -d STR. If the flag is not set, predictions for all drugs will be 
      performed.
    inputBinding:
      position: 101
  - id: fastq_dir
    type: Directory
    doc: Path to the directory were the FASTQ files are located.
  - id: preprocess
    type:
      - 'null'
      - boolean
    doc: Run only the preprocessing steps.
    inputBinding:
      position: 101
      prefix: --preprocess
  - id: sample_id
    type: string
    doc: SampleID (i.e. ERR/SRR run accession).
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: skip_mtbseq
    type:
      - 'null'
      - boolean
    doc: Skip the MTBseq step. Precomputed output must be present in fastq-dir.
    inputBinding:
      position: 101
      prefix: --skip-mtbseq
  - id: output_dir_path
    type: string
    doc: Path to the directory were the final output files shall be stored.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Path to the directory were the final output files shall be stored.
    outputBinding:
      glob: $(inputs.output_dir_path)
arguments:
  - position: 101
    prefix: --fastq-dir
    valueFrom: $(inputs.fastq_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fastq_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1
