cwlVersion: v1.2
class: CommandLineTool
baseCommand: Blacklist
label: encode-blacklist_Blacklist
doc: "Blacklist is used to generate the ENCODE blacklists for various species. It
  builds the blacklist for one chromosome or contig and writes BED regions to the
  standard output. The tool reads sorted and indexed BAM files from an input/ folder
  and Umap uint8 mappability tracks from a mappability/ folder in the working directory.\n\
  \nTool homepage: https://github.com/Boyle-Lab/Blacklist"
inputs:
  - id: chr
    type: string
    doc: Chromosome or contig name (for example chr1); BAM files must be named
      <chr>.bam and mappability files <chr>.uint8.unique
    inputBinding:
      position: 1
  - id: input_bam_files
    type:
      type: array
      items: File
    doc: Sorted BAM files and their .bai indexes, staged into the input/ folder
  - id: mappability_files
    type:
      type: array
      items: File
    doc: Umap uint8 mappability files (<chr>.uint8.unique), staged into the
      mappability/ folder
outputs:
  - id: blacklist_bed
    type: stdout
    doc: Blacklist regions in BED format
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        for (var i = 0; i < inputs.input_bam_files.length; i++) {
          l.push({entry: inputs.input_bam_files[i], entryname: "input/" + inputs.input_bam_files[i].basename});
        }
        for (var j = 0; j < inputs.mappability_files.length; j++) {
          l.push({entry: inputs.mappability_files[j], entryname: "mappability/" + inputs.mappability_files[j].basename});
        }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encode-blacklist:2.0--h06902ac_6
stdout: encode-blacklist_Blacklist.bed
