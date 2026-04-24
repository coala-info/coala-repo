cwlVersion: v1.2
class: CommandLineTool
baseCommand: centreseq core
label: centreseq_core
doc: "Given an input directory containing any number of assemblies (.fasta), centreseq
  core will 1) annotate the genomes with Prokka, 2) perform self- clustering on each
  genome with MMSeqs2 linclust, 3) concatenate the self- clustered genomes into a
  single pan-genome, 4) cluster the pan-genome with MMSeqs2 linclust, establishing
  a core genome, 5) generate helpful reports to interrogate your dataset Note that
  if specified output directory already exists, centreseq will search for an existing
  Prokka directory and skip this step if possible.\n\nTool homepage: https://github.com/bfssi-forest-dussault/centreseq"
inputs:
  - id: coverage_length
    type:
      - 'null'
      - float
    doc: Sets the mmseqs cluster coverage parameter "-c" directly. Defaults to 
      0.95, which is the recommended setting.
    inputBinding:
      position: 101
      prefix: --coverage-length
  - id: fasta_dir
    type: Directory
    doc: Path to directory containing *.fasta files for input to the core 
      pipeline
    inputBinding:
      position: 101
      prefix: --fasta-dir
  - id: medoid_repseqs
    type:
      - 'null'
      - boolean
    doc: This setting will identify the representative medoid nucleotide 
      sequence for each core cluster. Enabling this will increase computation 
      time considerably. Note that this parameter has no effect on the number of
      core clusters detected.
    inputBinding:
      position: 101
      prefix: --medoid-repseqs
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: Sets the mmseqs cluster parameter "--min-seq-id".
    inputBinding:
      position: 101
      prefix: --min-seq-id
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to dedicate to parallelizable steps of the pipeline. 
      Will take all available CPUs - 1 by default.
    inputBinding:
      position: 101
      prefix: --n-cpu
  - id: n_cpu_medoid
    type:
      - 'null'
      - int
    doc: Number of CPUs for the representative medoid picking step (if enabled).
      You will need substantial RAM per CPU.
    inputBinding:
      position: 101
      prefix: --n-cpu-medoid
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: Generate pairwise comparisons of all core genomes. This setting allows 
      for viewing an interactive network chart which visualizes core genome 
      relatedness.
    inputBinding:
      position: 101
      prefix: --pairwise
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set this flag to enable more verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type: Directory
    doc: Root directory to store all output files. If this directory already 
      exists, the pipeline will attempt to skip the Prokka step by reading in 
      the existing Prokka output directory, but will overwrite all other 
      existing result files.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centreseq:0.3.8--py_0
