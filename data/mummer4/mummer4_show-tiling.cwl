cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-tiling
label: mummer4_show-tiling
doc: "Output is to stdout, and consists of the predicted location of each aligning
  query contig as mapped to the reference sequences. These coordinates reference the
  extent of the entire query contig, even when only a certain percentage of the contig
  was actually aligned (unless the -a option is used). Columns are, start in ref,
  end in ref, distance to next contig, length of this contig, alignment coverage,
  identity, orientation, and ID respectively.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: deltafile
    type: File
    doc: Input is the .delta output of the nucmer program, run on very similar 
      sequence data, or the .delta output of the promer program, run on 
      divergent sequence data.
    inputBinding:
      position: 1
  - id: circular_reference
    type:
      - 'null'
      - boolean
    doc: Assume the reference sequences are circular, and allow tiled contigs to
      span the origin
    inputBinding:
      position: 102
      prefix: -c
  - id: describe_tiling_path_stdout
    type:
      - 'null'
      - boolean
    doc: Describe the tiling path by printing the tab-delimited alignment region
      coordinates to stdout
    inputBinding:
      position: 102
      prefix: -a
  - id: describe_tiling_path_xml_stdout
    type:
      - 'null'
      - boolean
    doc: Describe the tiling path by printing the XML contig linking information
      to stdout
    inputBinding:
      position: 102
      prefix: -x
  - id: handle_repetitive_contigs
    type:
      - 'null'
      - boolean
    doc: Deal with repetitive contigs by randomly placing them in one of their 
      copy locations (implies -V 0)
    inputBinding:
      position: 102
      prefix: -R
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Set maximum gap between clustered alignments [-1, INT_MAX] A value of 
      -1 will represent infinity (nucmer default = 1000) (promer default = -1)
    inputBinding:
      position: 102
      prefix: -g
  - id: min_contig_coverage
    type:
      - 'null'
      - float
    doc: Set minimum contig coverage to tile [0.0, 100.0] (nucmer default = 
      95.0) sum of individual alignments (promer default = 50.0) extent of 
      syntenic region
    inputBinding:
      position: 102
      prefix: -v
  - id: min_contig_coverage_difference
    type:
      - 'null'
      - float
    doc: Set minimum contig coverage difference [0.0, 100.0] i.e. the difference
      needed to determine one alignment is 'better' than another alignment 
      (nucmer default = 10.0) sum of individual alignments (promer default = 
      30.0) extent of syntenic region
    inputBinding:
      position: 102
      prefix: -V
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Set minimum length contig to report [-1, INT_MAX] A value of -1 will 
      represent infinity (common default = 1)
    inputBinding:
      position: 102
      prefix: -l
  - id: min_percent_identity
    type:
      - 'null'
      - float
    doc: Set minimum percent identity to tile [0.0, 100.0] (nucmer default = 
      90.0) (promer default = 55.0)
    inputBinding:
      position: 102
      prefix: -i
  - id: pseudo_molecule_output_file
    type:
      - 'null'
      - File
    doc: Output a pseudo molecule of the query contigs to 'file'
    inputBinding:
      position: 102
      prefix: -p
  - id: tigr_contig_list_output_file
    type:
      - 'null'
      - File
    doc: Output a TIGR style contig list of each query sequence that 
      sufficiently matches the reference (non-circular)
    inputBinding:
      position: 102
      prefix: -t
  - id: unusable_contigs_output_file
    type:
      - 'null'
      - File
    doc: Output the tab-delimited alignment region coordinates of the unusable 
      contigs to 'file'
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-tiling.out
