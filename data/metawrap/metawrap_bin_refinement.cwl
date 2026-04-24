cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - bin_refinement
label: metawrap_bin_refinement
doc: "Refine metagenomic bins from multiple sources.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: bin_folder_a
    type: Directory
    doc: folder with metagenomic bins (files must have .fa or .fasta extension)
    inputBinding:
      position: 101
      prefix: -A
  - id: bin_folder_b
    type:
      - 'null'
      - Directory
    doc: another folder with metagenomic bins
    inputBinding:
      position: 101
      prefix: -B
  - id: bin_folder_c
    type:
      - 'null'
      - Directory
    doc: another folder with metagenomic bins
    inputBinding:
      position: 101
      prefix: -C
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: 'for contigs that end up in more than one bin, keep them in all bins (default:
      keeps them only in the best bin)'
    inputBinding:
      position: 101
      prefix: --keep-ambiguous
  - id: max_contamination
    type:
      - 'null'
      - int
    doc: maximum % contamination of bins that is acceptable
    inputBinding:
      position: 101
      prefix: -x
  - id: memory
    type:
      - 'null'
      - int
    doc: memory available
    inputBinding:
      position: 101
      prefix: -m
  - id: min_completion
    type:
      - 'null'
      - int
    doc: minimum % completion of bins [should be >50%]
    inputBinding:
      position: 101
      prefix: -c
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: quick
    type:
      - 'null'
      - boolean
    doc: adds --reduced_tree option to checkm, reducing runtime, especially with
      low memory
    inputBinding:
      position: 101
      prefix: --quick
  - id: remove_ambiguous
    type:
      - 'null'
      - boolean
    doc: 'for contigs that end up in more than one bin, remove them in all bins (default:
      keeps them only in the best bin)'
    inputBinding:
      position: 101
      prefix: --remove-ambiguous
  - id: skip_checkm
    type:
      - 'null'
      - boolean
    doc: dont run CheckM to assess bins
    inputBinding:
      position: 101
      prefix: --skip-checkm
  - id: skip_consolidation
    type:
      - 'null'
      - boolean
    doc: choose the best version of each bin from all bin refinement iteration
    inputBinding:
      position: 101
      prefix: --skip-consolidation
  - id: skip_refinement
    type:
      - 'null'
      - boolean
    doc: dont use binning_refiner to come up with refined bins based on 
      combinations of binner outputs
    inputBinding:
      position: 101
      prefix: --skip-refinement
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap_bin_refinement.out
