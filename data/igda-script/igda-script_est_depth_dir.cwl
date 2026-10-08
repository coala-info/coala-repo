cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - est_depth_dir
label: igda-script_est_depth_dir
doc: "Estimate sequencing depth for every BAM file in a directory by submitting est_depth jobs with submitjob. Only works for single chromosome data.\nUsage: est_depth indir(has bamfiles) genome_size\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: "directory with BAM files; a .depth file is written beside each BAM"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: genome_size
    type: int
    doc: "genome size (bp)"
    inputBinding:
      position: 2
outputs:
  - id: depth_dir
    type: Directory
    doc: "input directory with the .depth files"
    outputBinding:
      glob: $(inputs.indir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.indir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
