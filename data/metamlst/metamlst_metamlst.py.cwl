cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst.py
label: metamlst_metamlst.py
doc: "Reconstruct the MLST loci from a BAMFILE aligned to the reference MLST loci\n\
  \nTool homepage: https://github.com/SegataLab/metamlst"
inputs:
  - id: bamfile
    type:
      - 'null'
      - File
    doc: BowTie2 BAM file containing the alignments
    inputBinding:
      position: 1
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: Specify a different MetaMLST-Database. If unset, use the default 
      Database. You can create a custom DB with metaMLST-index.py)
    inputBinding:
      position: 102
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug Mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: filter_species
    type:
      - 'null'
      - string
    doc: Filter for specific set of organisms only (METAMLST-KEYs, comma 
      separated. Use metaMLST-index.py --listspecies to get MLST keys)
    inputBinding:
      position: 102
      prefix: --filter
  - id: log
    type:
      - 'null'
      - boolean
    doc: generate logfiles
    inputBinding:
      position: 102
      prefix: --log
  - id: max_xm
    type:
      - 'null'
      - int
    doc: Maximum SNPs rate for each alignment to be considered valid (BowTie2s 
      XM value)
    inputBinding:
      position: 102
      prefix: --max_xM
  - id: min_accuracy
    type:
      - 'null'
      - float
    doc: Minimum threshold on Confidence score (percentage) to pass the 
      reconstruction step
    inputBinding:
      position: 102
      prefix: --min_accuracy
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Minimum BowTie2 alignment length
    inputBinding:
      position: 102
      prefix: --min_read_len
  - id: minscore
    type:
      - 'null'
      - int
    doc: Minimum alignment score for each alignment to be considered valid
    inputBinding:
      position: 102
      prefix: --minscore
  - id: nloci
    type:
      - 'null'
      - int
    doc: Do not discard samples where at least NLOCI (percent) are detected. 
      This can lead to imperfect MLST typing
    inputBinding:
      position: 102
      prefix: --nloci
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output Folder
    inputBinding:
      position: 102
      prefix: -o
  - id: penalty
    type:
      - 'null'
      - int
    doc: MetaMLST penaty for under-represented alleles
    inputBinding:
      position: 102
      prefix: --penalty
  - id: presorted
    type:
      - 'null'
      - boolean
    doc: The input BAM file is sorted and indexed with samtools. If set, 
      MetaMLST skips this step
    inputBinding:
      position: 102
      prefix: --presorted
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress text output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: write_known_sequences
    type:
      - 'null'
      - boolean
    doc: Write known sequences
    inputBinding:
      position: 102
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst.py.out
