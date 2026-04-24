cwlVersion: v1.2
class: CommandLineTool
baseCommand: Trinotate
label: trinotate_Trinotate
doc: "Trinotate: Annotation of,\"Trinity\"-assembled Transcriptome sequences.\n\n\
  Tool homepage: https://trinotate.github.io/"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: blast_type
    type:
      - 'null'
      - string
    doc: Type of custom BLAST (blastp|blastx)
    inputBinding:
      position: 102
      prefix: --blast_type
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 102
      prefix: --CPU
  - id: create
    type:
      - 'null'
      - boolean
    doc: Initial creation of the Trinotate sqlite database and downloading of 
      the required data sets
    inputBinding:
      position: 102
      prefix: --create
  - id: custom_db_name
    type:
      - 'null'
      - string
    doc: Name for the custom database in the report
    inputBinding:
      position: 102
      prefix: --custom_db_name
  - id: db
    type: File
    doc: sqlite.db file
    inputBinding:
      position: 102
      prefix: --db
  - id: e_value
    type:
      - 'null'
      - float
    doc: E-value cutoff for report
    inputBinding:
      position: 102
      prefix: -E
  - id: gene_trans_map
    type:
      - 'null'
      - File
    doc: Gene to transcript map file
    inputBinding:
      position: 102
      prefix: --gene_trans_map
  - id: incl_pep
    type:
      - 'null'
      - boolean
    doc: Include peptide sequences in the report
    inputBinding:
      position: 102
      prefix: --incl_pep
  - id: incl_trans
    type:
      - 'null'
      - boolean
    doc: Include transcript sequences in the report
    inputBinding:
      position: 102
      prefix: --incl_trans
  - id: init
    type:
      - 'null'
      - boolean
    doc: Initial import of transcriptome and protein data
    inputBinding:
      position: 102
      prefix: --init
  - id: load_custom_blast
    type:
      - 'null'
      - File
    doc: Load custom BLAST results
    inputBinding:
      position: 102
      prefix: --LOAD_custom_blast
  - id: load_deeptmhmm
    type:
      - 'null'
      - File
    doc: Load DeepTMHMM results
    inputBinding:
      position: 102
      prefix: --LOAD_deeptmhmm
  - id: load_eggnogmapper
    type:
      - 'null'
      - File
    doc: Load EggNog-Mapper results
    inputBinding:
      position: 102
      prefix: --LOAD_EggnogMapper
  - id: load_infernal
    type:
      - 'null'
      - File
    doc: Load Infernal results
    inputBinding:
      position: 102
      prefix: --LOAD_infernal
  - id: load_pfam
    type:
      - 'null'
      - File
    doc: Load Pfam results
    inputBinding:
      position: 102
      prefix: --LOAD_pfam
  - id: load_signalp
    type:
      - 'null'
      - File
    doc: Load SignalP results
    inputBinding:
      position: 102
      prefix: --LOAD_signalp
  - id: load_swissprot_blastp
    type:
      - 'null'
      - File
    doc: Load SwissProt BLASTP results
    inputBinding:
      position: 102
      prefix: --LOAD_swissprot_blastp
  - id: load_swissprot_blastx
    type:
      - 'null'
      - File
    doc: Load SwissProt BLASTX results
    inputBinding:
      position: 102
      prefix: --LOAD_swissprot_blastx
  - id: load_tmhmmv2
    type:
      - 'null'
      - File
    doc: Load TMHMMv2 results
    inputBinding:
      position: 102
      prefix: --LOAD_tmhmmv2
  - id: pfam_cutoff
    type:
      - 'null'
      - string
    doc: Pfam cutoff (DNC|DGC|DTC|SNC|SGC|STC)
    inputBinding:
      position: 102
      prefix: --pfam_cutoff
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate report
    inputBinding:
      position: 102
      prefix: --report
  - id: run
    type:
      - 'null'
      - type: array
        items: string
    doc: Run specific annotation computes or ALL
    inputBinding:
      position: 102
      prefix: --run
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: Transcriptome FASTA file
    inputBinding:
      position: 102
      prefix: --transcript_fasta
  - id: transdecoder_pep
    type:
      - 'null'
      - File
    doc: TransDecoder predicted protein FASTA file
    inputBinding:
      position: 102
      prefix: --transdecoder_pep
  - id: trinotate_data_dir
    type:
      - 'null'
      - Directory
    doc: Directory to download Trinotate data
    inputBinding:
      position: 102
      prefix: --trinotate_data_dir
  - id: use_diamond
    type:
      - 'null'
      - boolean
    doc: Use diamond blast instead of ncbi blast
    inputBinding:
      position: 102
      prefix: --use_diamond
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
stdout: trinotate_Trinotate.out
