cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucdiff
label: nucdiff
doc: "Compares two fasta files and outputs differences\n\nTool homepage: https://github.com/uio-cels/NucDiff"
inputs:
  - id: reference_fasta
    type: File
    doc: Fasta file with the reference sequences
    inputBinding:
      position: 1
  - id: query_fasta
    type: File
    doc: Fasta file with the query sequences
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: Path to the directory where all intermediate and final results will be 
      stored
    inputBinding:
      position: 3
  - id: prefix
    type: string
    doc: Name that will be added to all generated files including the ones 
      created by NUCmer
    inputBinding:
      position: 4
  - id: delta_file
    type:
      - 'null'
      - File
    doc: Path to the already existing delta file (NUCmer output file)
    inputBinding:
      position: 105
      prefix: --delta_file
  - id: filter_opt
    type:
      - 'null'
      - string
    doc: Delta-filter run options. By default, it will be run with -q parameter 
      only. -q is hard coded and cannot be changed. To add any other parameter 
      values, type parameter names and their values inside single or double 
      quotation marks.
    inputBinding:
      position: 105
      prefix: --filter_opt
  - id: nucmer_opt
    type:
      - 'null'
      - string
    doc: NUCmer run options. By default, NUCmer will be run with its default 
      parameters values, except the --maxmatch parameter. --maxmatch is hard 
      coded and cannot be changed. To change any other parameter values, type 
      parameter names and new values inside single or double quotation marks.
    inputBinding:
      position: 105
      prefix: --nucmer_opt
  - id: proc
    type:
      - 'null'
      - int
    doc: Number of processes to be used
    default: 1
    inputBinding:
      position: 105
      prefix: --proc
  - id: query_name_full
    type:
      - 'null'
      - string
    doc: Print full query names in output files ('yes' value). In case of 'no', 
      everything after the first space will be ignored.
    default: no
    inputBinding:
      position: 105
      prefix: --query_name_full
  - id: ref_name_full
    type:
      - 'null'
      - string
    doc: Print full reference names in output files ('yes' value). In case of 
      'no', everything after the first space will be ignored.
    default: no
    inputBinding:
      position: 105
      prefix: --ref_name_full
  - id: reloc_dist
    type:
      - 'null'
      - int
    doc: Minimum distance between two relocated blocks
    default: 10000
    inputBinding:
      position: 105
      prefix: --reloc_dist
  - id: vcf
    type:
      - 'null'
      - string
    doc: Output small and medium local differences in the VCF format
    inputBinding:
      position: 105
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucdiff:2.0.3--pyh864c0ab_1
stdout: nucdiff.out
