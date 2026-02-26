cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgca
label: mgca
doc: "microbial genome component and annotation pipeline\n\nTool homepage: https://github.com/liaochenlanruo/mgca/blob/master/README.md"
inputs:
  - id: aa_suffix
    type:
      - 'null'
      - string
    doc: Specify the suffix of Protein sequence files
    default: .faa
    inputBinding:
      position: 101
      prefix: --aa_suffix
  - id: aas_path
    type:
      - 'null'
      - Directory
    doc: Amino acids of all strains as fasta file paths
    inputBinding:
      position: 101
      prefix: --AAsPath
  - id: cas_db_path
    type:
      - 'null'
      - Directory
    doc: The full path of cas database, not include the database name and the 
      last '/' of the path
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --casDBpath
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print citation for referencing Prokka.
    inputBinding:
      position: 101
      prefix: --citation
  - id: crispr
    type:
      - 'null'
      - boolean
    doc: Finding CRISPR-Cas systems in genomics or metagenomics datasets.
    inputBinding:
      position: 101
      prefix: --CRISPR
  - id: gbk_path
    type:
      - 'null'
      - Directory
    doc: GenBank file path
    inputBinding:
      position: 101
      prefix: --gbkPath
  - id: gbk_suffix
    type:
      - 'null'
      - string
    doc: Specify the suffix of GenBank files
    default: .gbk
    inputBinding:
      position: 101
      prefix: --gbk_suffix
  - id: is
    type:
      - 'null'
      - boolean
    doc: Predict genomic island from GenBank files.
    inputBinding:
      position: 101
      prefix: --IS
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum contig size (in bp) to be included in the analysis. Smaller 
      contigs will be dropped
    default: 5000
    inputBinding:
      position: 101
      prefix: --min_contig_size
  - id: phage_genes
    type:
      - 'null'
      - int
    doc: The minimum number of genes that must be identified as belonging to a 
      phage for the region to be included
    default: 1
    inputBinding:
      position: 101
      prefix: --phage_genes
  - id: phmms
    type:
      - 'null'
      - File
    doc: Specify the path of pVOG.hmm
    default: /usr/local/bin/pVOGs.hmm
    inputBinding:
      position: 101
      prefix: --phmms
  - id: pi
    type:
      - 'null'
      - boolean
    doc: Calculate statistics of protein properties and print pI of all protein 
      sequences.
    inputBinding:
      position: 101
      prefix: --PI
  - id: prophage
    type:
      - 'null'
      - boolean
    doc: Predict prophage sequences from GenBank files.
    inputBinding:
      position: 101
      prefix: --PROPHAGE
  - id: scaf_path
    type:
      - 'null'
      - Directory
    doc: Genome/Scaffolds/Contigs file path
    inputBinding:
      position: 101
      prefix: --scafPath
  - id: scaf_suffix
    type:
      - 'null'
      - string
    doc: Specify the suffix of Genome/Scaffolds/Contigs files
    default: .fa
    inputBinding:
      position: 101
      prefix: --scaf_suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 6
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgca:0.0.0--pl5321hdfd78af_0
stdout: mgca.out
