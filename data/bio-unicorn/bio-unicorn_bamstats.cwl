cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - bamstats
label: bio-unicorn_bamstats
doc: "Compute per bam statistics (alignments, reads, read length, ANI, covered bases).\n
  \nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: input_bam
    type:
      - 'null'
      - File
    doc: input bam|sam|cram
    inputBinding:
      position: 1
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix; writes <prefix>.stats.txt (statistics go to stdout when
      not set)
    inputBinding:
      position: 1
      prefix: -o
  - id: filelist
    type:
      - 'null'
      - File
    doc: File containing input file paths. One per line. Give the files in 
      list_files so that the names resolve.
    inputBinding:
      position: 1
      prefix: --filelist
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM/SAM/CRAM files named in the file list, staged in the working 
      directory
  - id: printdists
    type:
      - 'null'
      - boolean
    doc: Print distributions of read lengths, alignment lengths, etc. This will
      create files <inputname>.*.dists.txt
    inputBinding:
      position: 1
      prefix: --printdists
outputs:
  - id: stats_stdout
    type: stdout
    doc: Per-BAM statistics table (when no output prefix is given)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Per-BAM statistics table <prefix>.stats.txt
    outputBinding:
      glob: "${ return inputs.output_prefix ? inputs.output_prefix + '.stats.txt' : []; }"
  - id: dists
    type:
      type: array
      items: File
    doc: Distribution files <inputname>.*.dists.txt (with --printdists)
    outputBinding:
      glob: '*.dists.txt'
stdout: bio-unicorn_bamstats.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.list_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
