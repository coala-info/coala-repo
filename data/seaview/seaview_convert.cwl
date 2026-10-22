cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_convert
doc: "convert an input alignment to another format (no window creation)\n\nTool homepage: http://doua.prabi.fr/software/seaview"
inputs:
  - id: convert_mode
    type: ['null', boolean]
    default: true
    doc: "Select the non-interactive mode: convert an input alignment to another format (no window creation)"
    inputBinding:
      position: 1
      prefix: -convert
  - id: output_format
    type: ['null', string]
    doc: "format of the converted alignment file (mase, phylip, clustal, msf, fasta, or nexus)"
    inputBinding:
      position: 2
      prefix: -output_format
  - id: output_file
    type: ['null', string]
    doc: "use fname as name of the converted alignment (default is built from input filename)"
    inputBinding:
      position: 2
      prefix: -o
  - id: translate
    type: ['null', boolean]
    doc: "translate input sequences to protein before outputting them (don't use -sites)"
    inputBinding:
      position: 2
      prefix: -translate
  - id: no_terminal_stop
    type: ['null', boolean]
    doc: "translate terminal stop codons as a gap (with -translate option)"
    inputBinding:
      position: 2
      prefix: -no_terminal_stop
  - id: del_gap_only_sites
    type: ['null', boolean]
    doc: "remove all gap-only sites from alignment (don't use the -sites option)"
    inputBinding:
      position: 2
      prefix: -del_gap_only_sites
  - id: def_species_group
    type: ['null', string]
    doc: "create a species group of given name and members: group_name,group_member_ranks (ranks as in 3-8,12,19)"
    inputBinding:
      position: 2
      prefix: -def_species_group
  - id: def_site_selection
    type: ['null', string]
    doc: "create a selection of sites of given name and endpoints: name,endpoints (as in 10-200,305,310-342)"
    inputBinding:
      position: 2
      prefix: -def_site_selection
  - id: gblocks
    type: ['null', boolean]
    doc: "create under the name 'Gblocks' a set of blocks of conserved sites with the Gblocks program (requires the nexus or mase output formats)"
    inputBinding:
      position: 2
      prefix: -gblocks
  - id: gblocks_b4
    type: ['null', boolean]
    doc: "allow smaller final blocks"
    inputBinding:
      position: 2
      prefix: -b4
  - id: gblocks_b5
    type: ['null', boolean]
    doc: "allow gaps within final blocks"
    inputBinding:
      position: 2
      prefix: -b5
  - id: gblocks_b2
    type: ['null', boolean]
    doc: "less strict flanking positions"
    inputBinding:
      position: 2
      prefix: -b2
  - id: gblocks_b3
    type: ['null', boolean]
    doc: "don't allow many contiguous nonconserved positions"
    inputBinding:
      position: 2
      prefix: -b3
  - id: sites
    type: ['null', string]
    doc: "use the named selection of sites from the input alignment"
    inputBinding:
      position: 2
      prefix: -sites
  - id: species
    type: ['null', string]
    doc: "use the named group of species from the input alignment"
    inputBinding:
      position: 2
      prefix: -species
  - id: bootstrap
    type: ['null', int]
    doc: "writes n bootstrap replicates of the input alignment to the output file"
    inputBinding:
      position: 2
      prefix: -bootstrap
  - id: fontsize
    type: ['null', int]
    doc: "font size used for the tree plot or alignment windows"
    inputBinding:
      position: 2
      prefix: -fontsize
  - id: fast
    type: ['null', boolean]
    doc: "sequences will be displayed faster but less smoothly"
    inputBinding:
      position: 2
      prefix: -fast
  - id: input_file
    type: File
    doc: "alignment or sequence file to be read (always the last argument)"
    inputBinding:
      position: 99
outputs:
  - id: output_result
    type: ['null', File]
    doc: Output written with -o
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_convert.out
