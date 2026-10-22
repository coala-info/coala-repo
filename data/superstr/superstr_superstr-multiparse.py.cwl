cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr-multiparse.py
label: superstr_superstr-multiparse.py
doc: "Post-process superSTR per-read output of a set of samples into per-sample and per-motif files, using a manifest file.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: manifest
    type: File
    doc: Manifest path (four columns, tab-separated - sample ID, case/control, path to the superSTR per_read.txt.gz file, group label). The file name in column 3 is matched to the staged per_read_files; the wrapper rewrites the paths to absolute paths in the working directory, because the tool compares absolute paths with the manifest text.
    loadContents: true
  - id: per_read_files
    type:
      type: array
      items: File
    doc: superSTR per_read.txt.gz files named in the manifest; staged in the working directory so the relative paths in the manifest resolve
  - id: manifest_abs
    type: string
    default: manifest_abs.tsv
    doc: Name of the manifest copy with absolute paths that is passed to the tool
    inputBinding:
      position: 1
      prefix: --manifest
  - id: output
    type: string
    doc: Output path for files
    inputBinding:
      position: 2
      prefix: --output
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Clobber existing files.
    inputBinding:
      position: 3
      prefix: --clobber
  - id: readlength
    type:
      - 'null'
      - int
    doc: Manually set read length (default 150nt).
    inputBinding:
      position: 4
      prefix: --readlength
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for multiparser execution (default=4)
    inputBinding:
      position: 5
      prefix: '-@'
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with samples/ and motifs/ files
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.per_read_files)
      - entryname: manifest_abs.tsv
        entry: |
          ${
            var lines = inputs.manifest.contents.split("\n").filter(function(l) { return l.trim() !== ""; });
            var out = lines.map(function(l) {
              var p = l.trim().split(/\s+/);
              var base = p[2].split("/").pop();
              p[2] = runtime.outdir + "/" + base;
              return p.join("\t");
            });
            return out.join("\n") + "\n";
          }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
