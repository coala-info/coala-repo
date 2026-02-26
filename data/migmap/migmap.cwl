cwlVersion: v1.2
class: CommandLineTool
baseCommand: migmap
label: migmap
doc: "MIGMAP aligns immune receptor sequences to reference databases.\n\nTool homepage:
  https://github.com/mikessh/migmap"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file (can be gzipped).
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output file name or '-' for stdout.
    inputBinding:
      position: 2
  - id: all_alleles
    type:
      - 'null'
      - boolean
    doc: Will use all alleles during alignment (this is going to be slower). 
      [default = use only major (*01) alleles]
    inputBinding:
      position: 103
      prefix: --all-alleles
  - id: allow_incomplete
    type:
      - 'null'
      - boolean
    doc: Report clonotypes with partial CDR3 mapping.
    inputBinding:
      position: 103
      prefix: --allow-incomplete
  - id: allow_no_cdr3
    type:
      - 'null'
      - boolean
    doc: Report clonotypes with no CDR3 mapping.
    inputBinding:
      position: 103
      prefix: --allow-no-cdr3
  - id: allow_noncanonical
    type:
      - 'null'
      - boolean
    doc: Report clonotypes that have non-canonical CDR3 (do not start with C or 
      end with F/W residues).
    inputBinding:
      position: 103
      prefix: --allow-noncanonical
  - id: allow_noncoding
    type:
      - 'null'
      - boolean
    doc: Report clonotypes that have either stop codon or frameshift in their 
      receptor sequence.
    inputBinding:
      position: 103
      prefix: --allow-noncoding
  - id: blast_dir
    type:
      - 'null'
      - Directory
    doc: Path to folder that contains 'igblastn' and 'makeblastdb' binaries. 
      [default = assume they are added to $PATH and execute them directly]
    inputBinding:
      position: 103
      prefix: --blast-dir
  - id: by_read
    type:
      - 'null'
      - boolean
    doc: Will output mapping details for each read. [default = assemble 
      clonotypes and output clonotype abundance table]
    inputBinding:
      position: 103
      prefix: --by-read
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use.
    default: all available processors
    inputBinding:
      position: 103
      prefix: -p
  - id: custom_database
    type:
      - 'null'
      - Directory
    doc: Path to a custom segments database. [default = use built-in database]
    inputBinding:
      position: 103
      prefix: --custom-database
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to folder that contains data bundle (internal_data/ and 
      optional_file/ directories). [default = $install_dir/data/]
    inputBinding:
      position: 103
      prefix: --data-dir
  - id: details
    type:
      - 'null'
      - string
    doc: 'Additional fields to provide for output, allowed values: fr1nt,cdr1nt,fr2nt,cdr2nt,fr3nt,fr4nt,contignt,fr1aa,cdr1aa,fr2aa,cdr2aa,fr3aa,fr4aa,contigaa.'
    inputBinding:
      position: 103
      prefix: --details
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: Number of reads to take.
    default: all
    inputBinding:
      position: 103
      prefix: -n
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for average quality of mutations and N-regions of CDR3
    default: 25
    inputBinding:
      position: 103
      prefix: -q
  - id: receptor_gene_chain
    type:
      type: array
      items: string
    doc: 'Receptor gene and chain. Several chains can be specified, separated with
      commas. Allowed values: [TRA, TRB, TRG, TRD, IGH, IGL, IGK].'
    inputBinding:
      position: 103
      prefix: -R
  - id: species
    type: string
    doc: 'Species. Allowed values: [human, mouse, rat, rabbit, rhesus_monkey].'
    inputBinding:
      position: 103
      prefix: -S
  - id: use_kabat
    type:
      - 'null'
      - boolean
    doc: Will use KABAT nomenclature for CDR/FW partitioning. [default = use 
      IMGT nomenclature]
    inputBinding:
      position: 103
      prefix: --use-kabat
outputs:
  - id: report_file
    type:
      - 'null'
      - File
    doc: File to store MIGMAP report. Will append report line if file exists.
    outputBinding:
      glob: $(inputs.report_file)
  - id: unmapped_output
    type:
      - 'null'
      - File
    doc: Output unmapped reads in specified file.
    outputBinding:
      glob: $(inputs.unmapped_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migmap:1.0.3--0
