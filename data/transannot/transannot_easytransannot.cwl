cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transannot
  - easytransannot
label: transannot_easytransannot
doc: "By Mariia Zelenskaia mariia.zelenskaia@mpinat.mpg.de & Yazhini A. yazhini@mpinat.mpg.de\n\
  \nTool homepage: https://github.com/soedinglab/transannot"
inputs:
  - id: input_fastx_files
    type:
      type: array
      items: File
    doc: Input fasta or fastq files (can be gzipped or bz2 compressed)
    inputBinding:
      position: 1
  - id: target_db_1
    type: File
    doc: Target database file
    inputBinding:
      position: 2
  - id: target_db_2
    type: File
    doc: Target database file
    inputBinding:
      position: 3
  - id: target_db_3
    type: File
    doc: Target database file
    inputBinding:
      position: 4
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 5
  - id: compressed_output
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 106
      prefix: --compressed
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode)
    inputBinding:
      position: 106
      prefix: -c
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works
      only with single line fasta/q)'
    inputBinding:
      position: 106
      prefix: --createdb-mode
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0)
    inputBinding:
      position: 106
      prefix: --min-seq-id
  - id: no_run_clust
    type:
      - 'null'
      - boolean
    doc: Per default there is linclust of mmseqs performed for the redundancy 
      reduction. If you don't want it, provide this tag
    inputBinding:
      position: 106
      prefix: --no-run-clust
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    inputBinding:
      position: 106
      prefix: --remove-tmp-files
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    inputBinding:
      position: 106
      prefix: -s
  - id: simple_output
    type:
      - 'null'
      - boolean
    doc: Provide only query, target IDs and information from UniProt in the 
      output file. No information about alignment (eg. sequence identity and bit
      score)
    inputBinding:
      position: 106
      prefix: --simple-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 106
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 106
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transannot:4.0.0--pl5321hd6d6fdc_2
