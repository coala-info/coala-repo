cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcgTree.pl
label: bcgtree
doc: "Bacterial phylogenomic tree construction from proteomes or genomes. The tool finds
  107 essential single-copy core genes with hmmsearch, aligns them with muscle, cleans
  the alignment with Gblocks and builds a tree with RAxML.\n\nTool homepage: https://github.com/molbiodiv/bcgtree"
inputs:
  - id: proteome
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --proteome
          valueFrom: $(self.nameroot + "=" + self.path)
    doc: Proteomes as peptide FASTA files; the file name without extension is used as
      the organism name
    inputBinding:
      position: 101
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --genome
          valueFrom: $(self.nameroot + "=" + self.path)
    doc: Genomes as nucleotide FASTA files (genes are called with prodigal); the file
      name without extension is used as the organism name
    inputBinding:
      position: 101
  - id: check_external_programs
    type:
      - 'null'
      - boolean
    doc: Check if all of the required external programs can be found and are executable,
      then exit
    inputBinding:
      position: 101
      prefix: --check-external-programs
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to be used (currently only relevant for raxml). Default: 2'
    inputBinding:
      position: 101
      prefix: --threads=
      separate: false
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: 'Number of bootstraps to be used (passed to raxml). Default: 100'
    inputBinding:
      position: 101
      prefix: --bootstraps=
      separate: false
  - id: min_proteomes
    type:
      - 'null'
      - int
    doc: 'Minimum number of proteomes in which a gene must occur in order to be kept.
      Default: 2'
    inputBinding:
      position: 101
      prefix: --min-proteomes=
      separate: false
  - id: all_proteomes
    type:
      - 'null'
      - boolean
    doc: Sets --min-proteomes to the total number of proteomes supplied
    inputBinding:
      position: 101
      prefix: --all-proteomes
  - id: hmmfile
    type:
      - 'null'
      - File
    doc: 'Path to HMM file to be used for hmmsearch. Default: <bcgTreeDir>/data/essential.hmm'
    inputBinding:
      position: 101
      prefix: --hmmfile=
      separate: false
  - id: raxml_x_seed
    type:
      - 'null'
      - int
    doc: Random number seed for raxml (passed through as -x option to raxml)
    inputBinding:
      position: 101
      prefix: --raxml-x-rapidBootstrapRandomNumberSeed=
      separate: false
  - id: raxml_p_seed
    type:
      - 'null'
      - int
    doc: Random number seed for raxml (passed through as -p option to raxml)
    inputBinding:
      position: 101
      prefix: --raxml-p-parsimonyRandomSeed=
      separate: false
  - id: raxml_aa_substitution_model
    type:
      - 'null'
      - string
    doc: 'The aminoacid substitution model used for the partitions by RAxML. Default:
      AUTO'
    inputBinding:
      position: 101
      prefix: --raxml-aa-substitiution-model
  - id: raxml_args
    type:
      - 'null'
      - string
    doc: Arbitrary options to pass through to RAxML
    inputBinding:
      position: 101
      prefix: --raxml-args
  - id: outdir_path
    type:
      - 'null'
      - string
    default: bcgTree
    doc: 'Output directory for the generated output files (default: bcgTree)'
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory with alignments, RAxML trees and logs
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcgtree:1.2.1--pl5321hdfd78af_0
