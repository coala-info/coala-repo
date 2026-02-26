cwlVersion: v1.2
class: CommandLineTool
baseCommand: iCLIPro
label: iclipro_iCLIPro
doc: "For given input BAM file [in.bam] the script will generate a number of output
  files that can be used to check for and diagnose systematic misassignments in iCLIP
  data.\n\nTool homepage: http://www.biolab.si/iCLIPro/doc/"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: flanking_distance_overlap_ratio
    type:
      - 'null'
      - int
    doc: 'flanking distances when calculating start site overlap ratio (3..15, default:
      5)'
    default: 5
    inputBinding:
      position: 102
      prefix: -s
  - id: flanking_region_overlap_maps
    type:
      - 'null'
      - int
    doc: 'flanking region for read overlap maps (default: 50)'
    default: 50
    inputBinding:
      position: 102
      prefix: -f
  - id: genomic_bin_size
    type:
      - 'null'
      - int
    doc: 'genomic bin size (100..1000, default: 300)'
    default: 300
    inputBinding:
      position: 102
      prefix: -b
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'use only reads with minimum mapping quality (mapq) (0..100, default: 10)'
    default: 10
    inputBinding:
      position: 102
      prefix: -q
  - id: min_reads_in_bin
    type:
      - 'null'
      - int
    doc: 'number of reads required in bin (20..500, default: 50)'
    default: 50
    inputBinding:
      position: 102
      prefix: -r
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: output folder (default is cwd - current working directory)
    default: cwd
    inputBinding:
      position: 102
      prefix: -o
  - id: read_len_groups
    type:
      - 'null'
      - string
    doc: 'read len groups (e.g.: "A:16-39,A1:16-25,A2:26-32,A3:33-39,L:20,B:42")'
    inputBinding:
      position: 102
      prefix: -g
  - id: read_overlap_comparisons
    type:
      - 'null'
      - string
    doc: 'generate read overlap maps based on these comparisons (e.g.: "A1-A3,A2-A3,A1-B,A2-B,A3-B,L-B,A-B")'
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iclipro:0.1.1--py27_0
stdout: iclipro_iCLIPro.out
