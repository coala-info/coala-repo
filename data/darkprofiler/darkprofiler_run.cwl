cwlVersion: v1.2
class: CommandLineTool
baseCommand: darkprofiler_run
label: darkprofiler_run
doc: "Run darkprofiler\n\nTool homepage: https://pypi.org/project/darkprofiler/"
inputs:
  - id: reference_assembly
    type: string
    doc: Reference assembly version to use (must be downloaded first).
    inputBinding:
      position: 1
  - id: peptide_fasta
    type: File
    doc: Path to peptide FASTA file.
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 3
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Optional path to existing database directory containing 
      canonicalProteome.fa, alternativeSplicing.fa, mutanome.fa, 
      mutatedCanonicalTranscriptome.fa, mutatedAlternativeTranslatome.fa, and 
      other index files
    inputBinding:
      position: 104
      prefix: --database-path
  - id: hamming
    type:
      - 'null'
      - int
    doc: Hamming distance allowed for peptide search (0=exact, 1, or 2).
    default: 0
    inputBinding:
      position: 104
      prefix: --hamming
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Threads used for peptide search / verification.
    inputBinding:
      position: 104
      prefix: --num-threads
  - id: vcf_path
    type:
      - 'null'
      - File
    doc: Optional path to VCF or VCF.GZ file with SNVs.
    inputBinding:
      position: 104
      prefix: --vcf-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/darkprofiler:0.2.6--pyhdfd78af_0
stdout: darkprofiler_run.out
