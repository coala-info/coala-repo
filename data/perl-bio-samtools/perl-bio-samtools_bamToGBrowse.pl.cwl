cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamToGBrowse.pl
label: perl-bio-samtools_bamToGBrowse.pl
doc: "Convert SAM files in a directory to sorted, indexed BAM files, create BigWig coverage graphs and write a skeletal GBrowse config file named gbrowse.conf.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::Sam"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.directory_name)
        entry: "$({class: 'Directory', basename: inputs.directory_name, listing: inputs.input_files.concat(inputs.reference_fasta ? [inputs.reference_fasta] : [])})"
        writable: true
inputs:
  - id: directory_name
    type: string
    doc: Name of the working directory that holds the SAM or BAM files and receives the results
    inputBinding:
      position: 1
  - id: input_files
    type: 'File[]'
    doc: SAM files (.sam or .sam.gz) or sorted and indexed BAM files (<base>_sorted.bam with .bai) to place in the directory
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Fasta file of the reference sequence. If omitted, the script looks for ONE .fa file in the directory.
    inputBinding:
      position: 2
      valueFrom: $(inputs.directory_name + '/' + self.basename)
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the BAM, BigWig and gbrowse.conf results
    outputBinding:
      glob: $(inputs.directory_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
