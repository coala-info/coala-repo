cwlVersion: v1.2
class: CommandLineTool
baseCommand: index_bigwigset.pl
label: perl-bio-bigfile_index_bigwigset.pl
doc: "Search a directory for all BigWig files with the extension .bw and create a skeleton metadata.index file that you can use as a starting point for entering metadata about the collection.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::BigFile"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.directory_name)
        entry: "$({class: 'Directory', basename: inputs.directory_name, listing: inputs.bigwig_files})"
        writable: true
inputs:
  - id: bigwig_files
    type: 'File[]'
    doc: BigWig files (extension .bw) to place in the directory to be indexed
  - id: directory_name
    type: string
    doc: Name of the directory that holds the BigWig files and receives the metadata.index file
    inputBinding:
      position: 1
outputs:
  - id: metadata_index
    type: File
    doc: Skeleton metadata.index file written in the directory
    outputBinding:
      glob: $(inputs.directory_name)/metadata.index
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
