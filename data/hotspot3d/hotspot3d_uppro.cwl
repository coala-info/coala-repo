cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - uppro
label: hotspot3d_uppro
doc: "Generate proximity files for proteins using PDB data and distance measures.\n\
  \nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: d_distance_cutoff
    type:
      - 'null'
      - float
    doc: Maximum 3D distance (<= Angstroms)
    default: 100
    inputBinding:
      position: 101
      prefix: --3d-distance-cutoff
  - id: cmd_list_submit_file
    type:
      - 'null'
      - File
    doc: Batch jobs file to run calpro step in parallel
    default: cmd_list_submit_file
    inputBinding:
      position: 101
      prefix: --cmd-list-submit-file
  - id: gene_file
    type:
      - 'null'
      - File
    doc: File with HUGO gene names in the first column (like a .maf)
    inputBinding:
      position: 101
      prefix: --gene-file
  - id: hold
    type:
      - 'null'
      - boolean
    doc: Do not submit batch jobs, just write cmd_list_submit_file
    inputBinding:
      position: 101
      prefix: --hold
  - id: linear_distance_cutoff
    type:
      - 'null'
      - int
    doc: Minimum linear distance (> peptides)
    default: 0
    inputBinding:
      position: 101
      prefix: --linear-distance-cutoff
  - id: max_processes
    type:
      - 'null'
      - int
    doc: 'Set if using parallel type local (CAUTION: make sure you know your max CPU
      processes)'
    inputBinding:
      position: 101
      prefix: --max-processes
  - id: measure
    type: string
    doc: Distance measure between residues (shortest or average)
    inputBinding:
      position: 101
      prefix: --measure
  - id: parallel
    type: string
    doc: Parallelization to use (bsub, local, or none)
    inputBinding:
      position: 101
      prefix: --parallel
  - id: pdb_file_dir
    type: Directory
    doc: PDB file directory
    inputBinding:
      position: 101
      prefix: --pdb-file-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory of proximity files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
