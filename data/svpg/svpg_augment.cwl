cwlVersion: v1.2
class: CommandLineTool
baseCommand: svpg_augment
label: svpg_augment
doc: "Augment a pangenome graph with SV calls from sequencing reads.\n\nTool homepage:
  https://github.com/coopsor/SVPG"
inputs:
  - id: gfa
    type:
      - 'null'
      - File
    doc: Pangenome reference file that the long reads were aligned to (.gfa)
    inputBinding:
      position: 101
      prefix: --gfa
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: Minimum size of SVs to be detected. Set to -1 for unlimited size 
      (recommend somatic SV).
    default: -1
    inputBinding:
      position: 101
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for reads to be considered in SV detection.
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: Minimum size of SVs to be detected.
    inputBinding:
      position: 101
      prefix: --min_sv_size
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: read
    type:
      - 'null'
      - string
    doc: 'Type of sequencing reads: `ont` for Oxford Nanopore, `hifi` for PacBio HiFi.'
    inputBinding:
      position: 101
      prefix: --read
  - id: ref
    type:
      - 'null'
      - File
    doc: The reference genome used for pangenome construction (.fa), is also 
      serves as the coordinate system for SVPG’s SV call output.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_list
    type:
      - 'null'
      - File
    doc: 'Path to a TSV file listing the paths to FASTA files of new samples. if not
      provided, all FASTA files under `working_dir` will be processed. For example,
      the sample.tsv file may look like(sample_1 name ≠ sample_2 name): /path/to/sample_1.fasta
      /path/to/sample_2.fasta'
    inputBinding:
      position: 101
      prefix: --sample_list
  - id: skip_call
    type:
      - 'null'
      - boolean
    doc: Skip SV calling step and directly proceed to graph augmentation using 
      existing VCF files in the working directory.
    inputBinding:
      position: 101
      prefix: --skip_call
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify the working directory to store output files.
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Augmented GFA output file name
    outputBinding:
      glob: $(inputs.out)
  - id: vcf_out
    type:
      - 'null'
      - File
    doc: VCF output file name
    outputBinding:
      glob: $(inputs.vcf_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
