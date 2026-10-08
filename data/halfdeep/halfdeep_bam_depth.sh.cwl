cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_depth.sh
label: halfdeep_bam_depth.sh
doc: "Map one PacBio reads file to the reference with minimap2 (map-pb), sort the
  alignments with samtools and compute the coverage depth. Assumes <ref> and a
  minimap2 index <ref>.idx (name without the .fasta/.fa/.fsa_nt[.gz] extension)
  and input.fofn in the current directory. The reads file is the line <number>
  of input.fofn. Results are written to halfdeep/<ref>/mapped_reads/.\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs:
  - id: ref
    type: File
    doc: Reference assembly (.fa, .fasta, .fsa_nt, optionally gzipped)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: ref_index
    type: File
    doc: minimap2 index of the reference (minimap2 -x map-pb -d <ref>.idx
      <ref>.fasta); the name is the reference name without the fasta extension
      plus .idx
  - id: reads
    type:
      type: array
      items: File
    doc: Reads files (FASTA/FASTQ, optionally gzipped); written to input.fofn
      in the given order
  - id: number
    type: int
    doc: Line number in input.fofn of the reads file to process (1-based).
    inputBinding:
      position: 2
outputs:
  - id: halfdeep_dir
    type: Directory
    doc: Output directory halfdeep/<ref>/mapped_reads with the bam, sorted bam and depth files
    outputBinding:
      glob: halfdeep
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref)
      - entry: $(inputs.ref_index)
      - entry: $(inputs.reads)
      - entryname: input.fofn
        entry: |-
          ${
            return inputs.reads.map(function(f) { return f.basename; }).join("\n") + "\n";
          }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_bam_depth.sh.out
