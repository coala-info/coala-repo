cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyz_sfetch
label: usalign_xyz_sfetch
doc: "Index all entries in an xyz file into 'ca.xyz.index', or fetch the entries listed by 'list' from an indexed xyz file to stdout.\n\nTool homepage: https://zhanggroup.org/US-align"
inputs:
  - id: xyz_file
    type: File
    doc: xyz file (for example made by pdb2xyz); it is staged writable so that the index is written beside it
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - File
    doc: list of entries to fetch from the indexed xyz file
    inputBinding:
      position: 2
  - id: index_file
    type:
      - 'null'
      - File
    doc: existing index file of the xyz file (ca.xyz.index), staged beside the xyz file for fetching
outputs:
  - id: stdout
    type: stdout
    doc: Subset of the xyz entries (when a list is given)
  - id: index
    type:
      - 'null'
      - File
    doc: index file written beside the xyz file
    outputBinding:
      glob: '*.index'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{'entry': inputs.xyz_file, 'writable': true}];
        if (inputs.index_file) { l.push({'entry': inputs.index_file, 'entryname': inputs.xyz_file.basename + '.index'}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign_xyz_sfetch.out
