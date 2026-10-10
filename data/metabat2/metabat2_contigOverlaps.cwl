cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigOverlaps
label: metabat2_contigOverlaps
doc: "Report how reads span contigs between two or more assemblies given as lists of BAM files.\n\nTool homepage: https://bitbucket.org/berkeleylab/metabat"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.fofns || []).forEach(function (f) { l.push({entryname: f.basename, entry: f}); });
        (inputs.bam_files || []).forEach(function (f) { l.push({entryname: f.basename, entry: f}); });
        return l;
      }
inputs:
  - id: percent_identity
    type: 
      - 'null'
      - int
    doc: "The minimum end-to-end % identity of qualifying reads. Default: 97"
    inputBinding:
      position: 1
      prefix: --percentIdentity
  - id: fofns
    type:
      type: array
      items: File
    doc: "File-of-filenames lists of BAM files, one list per assembly (firstAssemblyBams.fofn secondAssemblyBams.fofn ...)"
    inputBinding:
      position: 2
  - id: bam_files
    type:
      type: array
      items: File
    doc: "BAM files named in the lists, staged in the working directory so the list entries resolve"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabat2:2.18--h6f16272_0
stdout: contigOverlaps.out
stderr: contigOverlaps.log
