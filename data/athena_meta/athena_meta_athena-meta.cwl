cwlVersion: v1.2
class: CommandLineTool
baseCommand: athena-meta
label: athena_meta_athena-meta
doc: "Athena Meta: A pipeline for assembling metagenomes\n\nTool homepage: https://github.com/abishara/athena_meta/"
inputs:
  - id: check_prereqs
    type:
      - 'null'
      - boolean
    doc: test if external deps visible in environment
    inputBinding:
      position: 101
      prefix: --check_prereqs
  - id: config
    type:
      - 'null'
      - File
    doc: 'input JSON config file for run, NOTE: dirname(config.json) specifies root
      output directory'
    inputBinding:
      position: 101
      prefix: --config
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files named in the JSON config (contig FASTA with its BWA index 
      files, reads-to-contig BAM with its .bai, interleaved FASTQ). They are 
      staged writable in the working directory, so relative names in the config 
      resolve.
  - id: force_reads
    type:
      - 'null'
      - boolean
    doc: proceed with subassembly even if input *bam and *fastq do not pass QC
    inputBinding:
      position: 101
      prefix: --force_reads
  - id: test
    type:
      - 'null'
      - boolean
    doc: run tiny assembly test to check setup and prereqs
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of multiprocessing threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: assembly
    type:
      - 'null'
      - File
    doc: Final Athena assembly (results/olc/athena.asm.fa).
    outputBinding:
      glob: results/olc/athena.asm.fa
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: Results directory written next to the config file.
    outputBinding:
      glob: results
  - id: logs_dir
    type:
      - 'null'
      - Directory
    doc: Log directory written next to the config file.
    outputBinding:
      glob: logs
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.config) { l.push(inputs.config); }
        if (inputs.input_files) {
          inputs.input_files.forEach(function (f) {
            l.push({entry: f, writable: true});
          });
        }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/athena_meta:1.3--py27_0
stdout: athena_meta_athena-meta.out
