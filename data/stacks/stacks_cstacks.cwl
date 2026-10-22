cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstacks
label: stacks_cstacks
doc: "Build a catalog of loci from sample data.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: catalog
    type:
      - 'null'
      - File
    doc: add to an existing catalog.
    inputBinding:
      position: 101
      prefix: --catalog
  - id: disable_gapped
    type:
      - 'null'
      - boolean
    doc: 'disable gapped alignments between stacks (default: use gapped alignments).'
    inputBinding:
      position: 101
      prefix: --disable-gapped
  - id: in_dir
    type:
      - 'null'
      - Directory
    doc: path to the directory containing Stacks files (copied writable; the catalog files are written into it with -P/-M)
    inputBinding:
      position: 101
      prefix: --in-path
  - id: k_len
    type:
      - 'null'
      - int
    doc: specify k-mer size for matching between between catalog loci 
      (automatically calculated by default).
    inputBinding:
      position: 101
      prefix: --k-len
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: 'number of gaps allowed between stacks before merging (default: 2).'
    inputBinding:
      position: 101
      prefix: --max-gaps
  - id: min_aln_len
    type:
      - 'null'
      - float
    doc: 'minimum length of aligned sequence in a gapped alignment (default: 0.80).'
    inputBinding:
      position: 101
      prefix: --min-aln-len
  - id: num_mismatches
    type:
      - 'null'
      - int
    doc: 'number of mismatches allowed between sample loci when build the catalog
      (default 1; suggested: set to ustacks -M).'
    inputBinding:
      position: 101
      prefix: -n
  - id: num_threads
    type:
      - 'null'
      - int
    doc: enable parallel execution with num_threads threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: popmap
    type:
      - 'null'
      - File
    doc: path to a population map file.
    inputBinding:
      position: 101
      prefix: --popmap
  - id: report_mmatches
    type:
      - 'null'
      - boolean
    doc: report query loci that match more than one catalog locus.
    inputBinding:
      position: 101
      prefix: --report-mmatches
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: sample files (.tags.tsv, .snps.tsv, .alleles.tsv) named by the -s prefixes; they are staged in the working directory
  - id: sample_prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -s
    doc: sample prefix from which to load loci into the catalog.
    inputBinding:
      position: 101
  - id: output_path_path
    type:
      - 'null'
      - string
    doc: ': output path to write results.'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: in_dir_out
    type:
      - 'null'
      - Directory
    doc: input directory with the catalog files written into it (-P/-M mode)
    outputBinding:
      glob: '${ return inputs.in_dir ? inputs.in_dir.basename : []; }'
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: output path to write results.
    outputBinding:
      glob: '${ return inputs.output_path_path ? inputs.output_path_path : []; }'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.in_dir) { l.push({"entry": inputs.in_dir, "writable": true}); }
        if (inputs.sample_files) { for (var i = 0; i < inputs.sample_files.length; i++) { l.push({"entry": inputs.sample_files[i], "writable": true}); } }
        if (inputs.catalog) { l.push({"entry": inputs.catalog, "writable": true}); }
        if (inputs.output_path_path) { l.push({"entryname": inputs.output_path_path, "entry": {"class": "Directory", "listing": []}, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
