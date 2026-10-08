cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep.sh
label: halfdeep_halfdeep.sh
doc: "Combine the per-reads depth files made by bam_depth.sh and identify
  half-deep intervals (scaffold, start, end; origin 1, closed). Assumes
  <ref>, input.fofn and halfdeep/<ref>/mapped_reads/*.depth.dat.gz in the
  current directory.\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs:
  - id: ref
    type: File
    doc: Reference assembly (.fa, .fasta, .fsa_nt, optionally gzipped)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: reads
    type:
      type: array
      items: File
    doc: Reads files that were mapped by bam_depth.sh, in the order of input.fofn
      (only their names are used)
  - id: depth_files
    type:
      type: array
      items: File
    doc: The <reads>.depth.dat.gz files made by bam_depth.sh, one per reads file
outputs:
  - id: halfdeep_dir
    type: Directory
    doc: Output directory halfdeep/<ref> with scaffold_lengths.dat, depth.dat.gz,
      percentile_commands.sh and halfdeep.dat
    outputBinding:
      glob: halfdeep
  - id: halfdeep_dat
    type: File
    doc: Half-deep intervals
    outputBinding:
      glob: halfdeep/*/halfdeep.dat
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var base = inputs.ref.basename.replace(/\.(fasta|fa|fsa_nt)(\.gz)?$/, "");
        var items = [
          {"entry": inputs.ref, "entryname": inputs.ref.basename},
          {"entry": inputs.reads.map(function(f) { return f.basename; }).join("\n") + "\n", "entryname": "input.fofn"}
        ];
        inputs.depth_files.forEach(function(f) {
          items.push({"entry": f, "entryname": "halfdeep/" + base + "/mapped_reads/" + f.basename, "writable": true});
        });
        return items;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_halfdeep.sh.out
