cwlVersion: v1.2
class: CommandLineTool
baseCommand: kobas_kobas-annotate
label: kobas_kobas-annotate
doc: "Annotate input sequences with functional information.\n\nTool homepage: http://kobas.cbi.pku.edu.cn"
inputs:
  - id: blast_home
    type:
      - 'null'
      - Directory
    doc: Optional parameter. To set parent directory of blastx and blastp. If 
      you set this parameter, it means you set "blastx" and "blastp" in this 
      following directory. Default value is read from ~/.kobasrc where you set 
      before running kobas
    inputBinding:
      position: 101
      prefix: --blasthome
  - id: blastdb
    type:
      - 'null'
      - Directory
    doc: Optional parameter. To set path to sep_pep/, default value is read from
      ~/.kobasrc where you set before running kobas
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: blastp
    type:
      - 'null'
      - File
    doc: Optional parameter. To set path to blastp program, default value is 
      read from ~/.kobasrc where you set before running kobas
    inputBinding:
      position: 101
      prefix: --blastp
  - id: blastx
    type:
      - 'null'
      - File
    doc: Optional parameter. To set path to  blasx program, default value is 
      read from ~/.kobasrc where you set before running kobas
    inputBinding:
      position: 101
      prefix: --blastx
  - id: coverage
    type:
      - 'null'
      - float
    doc: subject coverage cutoff for BLAST
    default: 0
    inputBinding:
      position: 101
      prefix: --coverage
  - id: evalue
    type:
      - 'null'
      - float
    doc: expect threshold for BLAST
    default: '1e-5'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: infile
    type: File
    doc: input data file
    inputBinding:
      position: 101
      prefix: --infile
  - id: intype
    type:
      - 'null'
      - string
    doc: input type (fasta:pro, fasta:nuc, blastout:xml, blastout:tab, 
      id:refseqpro, id:uniprot, id:ensembl, id:ncbigene)
    default: fasta:pro
    inputBinding:
      position: 101
      prefix: --intype
  - id: kobas_home
    type:
      - 'null'
      - Directory
    doc: Optional parameter. To set path to kobas_home, which is parent 
      directory of sqlite3/ and seq_pep/, default value is read from 
      ~/.kobasrcwhere you set before running kobas. If you set this parameter, 
      it means you set "kobasdb" and "blastdb" in this following directory. e.g.
      "-k /home/user/kobas/", means that you set kobasdb = 
      /home/user/kobas/sqlite3/ and blastdb = /home/user/kobas/seq_pep/
    inputBinding:
      position: 101
      prefix: --kobashome
  - id: kobasdb
    type:
      - 'null'
      - Directory
    doc: Optional parameter. To set path to sqlite3/, default value is read from
      ~/.kobasrc where you set before running kobas, e.g. "-q 
      /kobas_home/sqlite3/"
    inputBinding:
      position: 101
      prefix: --kobasdb
  - id: list_available
    type:
      - 'null'
      - boolean
    doc: list available species, or list available databases for a specific 
      species
    inputBinding:
      position: 101
      prefix: --list
  - id: ncpus
    type:
      - 'null'
      - int
    doc: number of CPUs to be used by BLAST
    default: 1
    inputBinding:
      position: 101
      prefix: --nCPUs
  - id: ortholog
    type:
      - 'null'
      - string
    doc: whether only use orthologs for cross-species annotation or not, default
      NO (if only use orthologs, please provide the species abbreviation of your
      input)
    default: NO
    inputBinding:
      position: 101
      prefix: --ortholog
  - id: rank
    type:
      - 'null'
      - int
    doc: rank cutoff for valid hits from BLAST result
    default: 5
    inputBinding:
      position: 101
      prefix: --rank
  - id: species
    type: string
    doc: 'species abbreviation (for example: ko for KEGG Orthology, hsa for Homo sapiens,
      mmu for Mus musculus, dme for Drosophila melanogaster, ath for Arabidopsis thaliana,
      sce for Saccharomyces cerevisiae and eco for Escherichia coli K-12 MG1655)'
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file for annotation result
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kobas:3.0.3--py27_1
