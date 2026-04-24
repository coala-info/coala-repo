cwlVersion: v1.2
class: CommandLineTool
baseCommand: yasma_jbrowse
label: yasma_jbrowse
doc: "Build coverage and config files for jbrowse2\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: annotation_conditions
    type: string
    doc: List of conditions names which will be included in the annotation. 
      Defaults to use all libraries, though this is likely not what you want if 
      you have multiple groups.
    inputBinding:
      position: 101
      prefix: --annotation_conditions
  - id: conditions
    type: string
    doc: Values denoting condition groups (sets of replicate libraries) for 
      projects with multiple tissues/treatments/genotypes. Can be entered here 
      as space sparated duplexes, with the library base_name and condition 
      groups delimited by a colon. E.g. SRR1111111:WT SRR1111112:WT 
      SRR1111113:mut SRR1111114:mut
    inputBinding:
      position: 101
      prefix: --conditions
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force remake of coverage files
    inputBinding:
      position: 101
      prefix: --force
  - id: gene_annotation_file
    type: File
    doc: Annotation file for genes (gff3) matching the included genome.
    inputBinding:
      position: 101
      prefix: --gene_annotation_file
  - id: genome_file
    type: File
    doc: Genome or assembly which was used for the original alignment.
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: include_subannotations
    type:
      - 'null'
      - boolean
    doc: Makes jbrowse entries for other annotations from the tradeoff module 
      than the primary annotation 'tradeoff'.
    inputBinding:
      position: 101
      prefix: --include_subannotations
  - id: jbrowse_directory
    type: Directory
    doc: A path to a working directory for a jbrowse2 instance.
    inputBinding:
      position: 101
      prefix: --jbrowse_directory
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum read size for specific coverage treatment
    inputBinding:
      position: 101
      prefix: --max_size
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum read size for specific coverage treatment
    inputBinding:
      position: 101
      prefix: --min_size
  - id: output_directory
    type: Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overrides config file changes without prompting.
    inputBinding:
      position: 101
      prefix: --override
  - id: overwrite_config
    type:
      - 'null'
      - boolean
    doc: Option to overwrite and make a new jbrowse config.json de novo.
    inputBinding:
      position: 101
      prefix: --overwrite_config
  - id: recopy
    type:
      - 'null'
      - boolean
    doc: Force recopy of all files to the jbrowse directory
    inputBinding:
      position: 101
      prefix: --recopy
  - id: remove_name
    type:
      - 'null'
      - string
    doc: Names of entries which should be removed from the config. These are 
      synonymous with the output_directories of the runs used. Use this with 
      caution!
    inputBinding:
      position: 101
      prefix: --remove_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_jbrowse.out
