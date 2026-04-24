cwlVersion: v1.2
class: CommandLineTool
baseCommand: bash run_metabinner.sh
label: metabinner_run_metabinner.sh
doc: "Run the MetaBinner pipeline\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs:
  - id: contig_file
    type: File
    doc: metagenomic assembly file
    inputBinding:
      position: 101
      prefix: -a
  - id: coverage_profile
    type: File
    doc: coverage_profile.tsv; The coverage profiles, containing a table where 
      each row correspond to a contig, and each column correspond to a sample. 
      All values are separated with tabs.
    inputBinding:
      position: 101
      prefix: -d
  - id: dataset_scale
    type:
      - 'null'
      - string
    doc: Dataset scale; eg. small,large,huge
    inputBinding:
      position: 101
      prefix: -s
  - id: kmer_profile
    type: File
    doc: kmer_profile.csv; The composition profiles, containing a table where 
      each row correspond to a contig, and each column correspond to the kmer 
      composition of particular kmer. All values are separated with comma.
    inputBinding:
      position: 101
      prefix: -k
  - id: path_to_metabinner
    type: Directory
    doc: path to MetaBinner; e.g. /home/wzy/MetaBinner
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
