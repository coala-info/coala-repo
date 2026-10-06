cwlVersion: v1.2
class: CommandLineTool
baseCommand: BaitFisher
label: baitfisher_BaitFisher
doc: "BaitFisher program for designing bait sets for phylogenomics and other applications.\n
  \nTool homepage: https://github.com/cmayer/BaitFisher-package"
inputs:
  - id: parameter_file
    type: File
    doc: The parameter file containing the configuration for the BaitFisher run.
    inputBinding:
      position: 1
  - id: gff_file_test
    type:
      - 'null'
      - File
    doc: Optional GFF file for testing.
    inputBinding:
      position: 2
  - id: transcript_files_directory
    type:
      - 'null'
      - Directory
    doc: Folder of alignment files named by directory-transcript-files in the 
      parameter file; it is staged in the working directory under its own name.
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Other files named in the parameter file (reference genome FASTA, GFF 
      file); they are staged in the working directory.
  - id: output_directory
    type: string
    default: BaitFisher-results
    doc: Value of output-directory in the parameter file. BaitFisher needs this 
      folder to exist; it is created empty before the run.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type: Directory
    doc: Output folder with the loci_baits.txt bait file
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.transcript_files_directory)
      - $(inputs.reference_files)
      - entry: '${ return {"class": "Directory", "basename": inputs.output_directory,
          "listing": [], "writable": true}; }'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
stdout: baitfisher_BaitFisher.out
