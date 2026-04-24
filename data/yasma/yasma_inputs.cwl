cwlVersion: v1.2
class: CommandLineTool
baseCommand: yasma_inputs
label: yasma_inputs
doc: "Initialize a project and log inputs for later analyses\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: annotation_conditions
    type:
      - 'null'
      - type: array
        items: string
    doc: List of conditions names which will be included in the annotation. 
      Defaults to use all libraries, though this is likely not what you want if 
      you have multiple groups.
    inputBinding:
      position: 101
      prefix: --annotation_conditions
  - id: conditions
    type:
      - 'null'
      - type: array
        items: string
    doc: Values denoting condition groups (sets of replicate libraries) for 
      projects with multiple tissues/treatments/genotypes. Can be entered here 
      as space sparated duplexes, with the library base_name and condition 
      groups delimited by a colon. E.g. SRR1111111:WT SRR1111112:WT 
      SRR1111113:mut SRR1111114:mut
    inputBinding:
      position: 101
      prefix: --conditions
  - id: gene_annotation_file
    type:
      - 'null'
      - File
    doc: Annotation file for genes (gff3) matching the included genome.
    inputBinding:
      position: 101
      prefix: --gene_annotation_file
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome or assembly which was used for the original alignment.
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: jbrowse_directory
    type:
      - 'null'
      - Directory
    doc: A path to a working directory for a jbrowse2 instance.
    inputBinding:
      position: 101
      prefix: --jbrowse_directory
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maxiumum allowed size for a trimmed read.
    inputBinding:
      position: 101
      prefix: --max_length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum allowed size for a trimmed read.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: output_directory
    type: Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: srrs
    type:
      - 'null'
      - type: array
        items: string
    doc: NCBI SRA codes for libraries. These will almost certainly start with 
      SRR or ERR.
    inputBinding:
      position: 101
      prefix: --srrs
  - id: trimmed_libraries
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to trimmed libraries. Accepts wildcards (*).
    inputBinding:
      position: 101
      prefix: --trimmed_libraries
  - id: untrimmed_libraries
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to untrimmed libraries. Accepts wildcards (*).
    inputBinding:
      position: 101
      prefix: --untrimmed_libraries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_inputs.out
