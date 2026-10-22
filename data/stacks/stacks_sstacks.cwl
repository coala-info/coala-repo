cwlVersion: v1.2
class: CommandLineTool
baseCommand: sstacks
label: stacks_sstacks
doc: "Stacks de novo assembly pipeline\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: catalog
    type:
      - 'null'
      - Directory
    doc: path to the catalog (directory holding catalog.tags.tsv, catalog.snps.tsv and catalog.alleles.tsv)
    inputBinding:
      position: 101
      prefix: --catalog
  - id: disable_gapped
    type:
      - 'null'
      - boolean
    doc: 'disable gapped alignments between stacks (default: enable gapped alignments).'
    inputBinding:
      position: 101
      prefix: --disable-gapped
  - id: dont_verify_haplotype
    type:
      - 'null'
      - boolean
    doc: don't verify haplotype of matching locus.
    inputBinding:
      position: 101
      prefix: -x
  - id: in_path
    type:
      - 'null'
      - Directory
    doc: path to the directory containing Stacks files (copied writable; the match files are written into it with -P/-M)
    inputBinding:
      position: 101
      prefix: --in-path
  - id: popmap
    type:
      - 'null'
      - File
    doc: path to a population map file from which to take sample names.
    inputBinding:
      position: 101
      prefix: --popmap
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample
    doc: filename prefix from which to load sample loci.
    inputBinding:
      position: 101
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: sample files named by the --sample prefixes; they are staged in the working directory
  - id: threads
    type:
      - 'null'
      - int
    doc: enable parallel execution with n_threads threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_path_path
    type:
      - 'null'
      - string
    doc: output path to write results (with -c/-s).
    inputBinding:
      position: 102
      prefix: --out-path
outputs:
  - id: in_path_out
    type:
      - 'null'
      - Directory
    doc: input directory with the match files written into it (-P/-M mode)
    outputBinding:
      glob: '${ return inputs.in_path ? inputs.in_path.basename : []; }'
  - id: out_path
    type:
      - 'null'
      - Directory
    doc: output path to write results.
    outputBinding:
      glob: '${ return inputs.out_path_path ? inputs.out_path_path : []; }'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.in_path) { l.push({"entry": inputs.in_path, "writable": true}); }
        if (inputs.sample_files) { for (var j = 0; j < inputs.sample_files.length; j++) { l.push({"entry": inputs.sample_files[j], "writable": true}); } }
        if (inputs.out_path_path) { l.push({"entryname": inputs.out_path_path, "entry": {"class": "Directory", "listing": []}, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
