cwlVersion: v1.2
class: CommandLineTool
baseCommand: zdb_run
label: zdb_run
doc: "Run the analysis pipeline (some analysis may not be available depending on which
  reference databases were setup)\n\nTool homepage: https://github.com/metagenlab/zDB/"
inputs:
  - id: amr
    type:
      - 'null'
      - boolean
    doc: perform amr (antibiotic resistance) annotation
    inputBinding:
      position: 101
      prefix: --amr
  - id: cog
    type:
      - 'null'
      - boolean
    doc: perform cog annotation
    inputBinding:
      position: 101
      prefix: --cog
  - id: conda
    type:
      - 'null'
      - boolean
    doc: use conda environments instead of singularity
    inputBinding:
      position: 101
      prefix: --conda
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel processes allowed (default 16)
    default: 16
    inputBinding:
      position: 101
      prefix: --cpu
  - id: docker
    type:
      - 'null'
      - boolean
    doc: use docker containers instead of singularity
    inputBinding:
      position: 101
      prefix: --docker
  - id: gi
    type:
      - 'null'
      - boolean
    doc: perform gi (genomic islands) annotation
    inputBinding:
      position: 101
      prefix: --gi
  - id: input
    type: File
    doc: CSV file containing the path to the genbank files to include in the 
      analsysis
    inputBinding:
      position: 101
      prefix: --input
  - id: ko
    type:
      - 'null'
      - boolean
    doc: perform ko (metabolism) annotation
    inputBinding:
      position: 101
      prefix: --ko
  - id: mem
    type:
      - 'null'
      - string
    doc: max memory usage allowed (default 8GB)
    default: 8GB
    inputBinding:
      position: 101
      prefix: --mem
  - id: name
    type:
      - 'null'
      - string
    doc: "run name (defaults to the name given by nextflow)\nthe latest completed
      run is also named latest"
    default: the name given by nextflow
    inputBinding:
      position: 101
      prefix: --name
  - id: num_missing
    type:
      - 'null'
      - int
    doc: allows for missing genomes for the determination of core orthogroups 
      (default 0)
    default: 0
    inputBinding:
      position: 101
      prefix: --num_missing
  - id: og_seq_aligner
    type:
      - 'null'
      - string
    doc: the sequence aligner to use for orthogroup prediction (blast or 
      diamond, defaults to diamond)
    default: diamond
    inputBinding:
      position: 101
      prefix: --og_seq_aligner
  - id: pfam
    type:
      - 'null'
      - boolean
    doc: peform PFAM domain annotation
    inputBinding:
      position: 101
      prefix: --pfam
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: directory where the reference databases were setup up (default zdb_ref)
    default: zdb_ref
    inputBinding:
      position: 101
      prefix: --ref_dir
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: search for homologs in the refseq database
    inputBinding:
      position: 101
      prefix: --refseq
  - id: resume
    type:
      - 'null'
      - boolean
    doc: wrapper for nextflow resume. Add this flag to the command that failed 
      to resume the execution where it stopped.
    inputBinding:
      position: 101
      prefix: --resume
  - id: singularity_dir
    type:
      - 'null'
      - Directory
    doc: the directory where the singularity images are downloaded (default 
      singularity in current directory)
    default: singularity in current directory
    inputBinding:
      position: 101
      prefix: --singularity_dir
  - id: swissprot
    type:
      - 'null'
      - boolean
    doc: search for homologs in the swissprot database
    inputBinding:
      position: 101
      prefix: --swissprot
  - id: vf_coverage
    type:
      - 'null'
      - float
    doc: coverage cutoff for query in blast against the VF database. Defaults to
      60%.
    default: 60%
    inputBinding:
      position: 101
      prefix: --vf_coverage
  - id: vf_evalue
    type:
      - 'null'
      - float
    doc: evalue cutoff for the blast against the VF database. Defaults to 1e-10.
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --vf_evalue
  - id: vf_seqid
    type:
      - 'null'
      - float
    doc: sequence id cutoff for filtering VF blast results. Defaults to 60%.
    default: 60%
    inputBinding:
      position: 101
      prefix: --vf_seqid
  - id: vfdb
    type:
      - 'null'
      - boolean
    doc: search for homologs in the virulence factor database
    inputBinding:
      position: 101
      prefix: --vfdb
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: directory where the files necessary for the webapp will be stored
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zdb:1.3.11--hdfd78af_0
