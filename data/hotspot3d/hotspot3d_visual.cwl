cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - visual
label: hotspot3d_visual
doc: "Visualize clusters and mutations using PyMol scripts\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: bg_color
    type:
      - 'null'
      - string
    doc: background color
    inputBinding:
      position: 101
      prefix: --bg-color
  - id: clusters_file
    type: File
    doc: Clusters file
    inputBinding:
      position: 101
      prefix: --clusters-file
  - id: clusters_file_type
    type:
      - 'null'
      - string
    doc: which clustering module created your clusters-file? network or density
    inputBinding:
      position: 101
      prefix: --clusters-file-type
  - id: compound_color
    type:
      - 'null'
      - string
    doc: compound color
    inputBinding:
      position: 101
      prefix: --compound-color
  - id: compound_style
    type:
      - 'null'
      - string
    doc: 'compound style, default: sticks if compound-color, util.cbag otherwise'
    inputBinding:
      position: 101
      prefix: --compound-style
  - id: drug_pairs_file
    type:
      - 'null'
      - File
    doc: A .drug*clean file (either target or nontarget)
    inputBinding:
      position: 101
      prefix: --drug-pairs-file
  - id: musites_file
    type:
      - 'null'
      - File
    doc: A .musites file
    inputBinding:
      position: 101
      prefix: --musites-file
  - id: mut_color
    type:
      - 'null'
      - string
    doc: mutation color
    inputBinding:
      position: 101
      prefix: --mut-color
  - id: mut_style
    type:
      - 'null'
      - string
    doc: mutation style
    inputBinding:
      position: 101
      prefix: --mut-style
  - id: pairwise_file
    type:
      - 'null'
      - File
    doc: A .pairwise file
    inputBinding:
      position: 101
      prefix: --pairwise-file
  - id: pdb
    type: string
    doc: PDB ID on which to view clusters
    inputBinding:
      position: 101
      prefix: --pdb
  - id: pdb_dir
    type:
      - 'null'
      - Directory
    doc: 'PDB file directory, default: current working directory'
    inputBinding:
      position: 101
      prefix: --pdb-dir
  - id: pymol
    type:
      - 'null'
      - File
    doc: PyMoL program location
    inputBinding:
      position: 101
      prefix: --pymol
  - id: script_only
    type:
      - 'null'
      - boolean
    doc: If included (on), pymol is not run with new <output-file> when finished
    inputBinding:
      position: 101
      prefix: --script-only
  - id: site_color
    type:
      - 'null'
      - string
    doc: site color
    inputBinding:
      position: 101
      prefix: --site-color
  - id: site_style
    type:
      - 'null'
      - string
    doc: site style
    inputBinding:
      position: 101
      prefix: --site-style
  - id: sites_file
    type:
      - 'null'
      - File
    doc: A .sites file
    inputBinding:
      position: 101
      prefix: --sites-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename for single PyMol script
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for multiple PyMol scripts, current working directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
