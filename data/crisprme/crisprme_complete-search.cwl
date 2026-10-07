cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crisprme.py
  - complete-search
label: crisprme_complete-search
doc: "End-to-end automated pipeline that takes the user-provided genome, variants, guides,
  PAM and annotation files, identifies potential CRISPR off-targets incorporating variant
  and haplotype information, scores each candidate guide, integrates annotation data
  and generates reports. Results are written to Results/<output> in the working directory.\n  \nTool homepage: https://github.com/samuelecancellieri/CRISPRme"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        (inputs.vcf_dirs || []).forEach(function(d) {
          l.push({entry: d, entryname: "VCFs/" + d.basename, writable: true});
        });
        (inputs.samples_id_files || []).forEach(function(f) {
          l.push({entry: f, entryname: "samplesIDs/" + f.basename, writable: true});
        });
        if (inputs.vcf) {
          l.push({entry: inputs.vcf, entryname: inputs.vcf.basename, writable: true});
        }
        if (inputs.samples_id) {
          l.push({entry: inputs.samples_id, entryname: inputs.samples_id.basename, writable: true});
        }
        return l;
      }
inputs:
  - id: genome
    type: Directory
    doc: Reference genome folder (FASTA files unzipped and separated by 
      chromosome)
    inputBinding:
      position: 1
      prefix: --genome
  - id: vcf
    type:
      - 'null'
      - File
    doc: File listing VCF folders (one per line); the folders are given in 
      vcf_dirs and staged in VCFs/ of the working directory, so list them by 
      folder name; staged writable because the pipeline appends to it
    inputBinding:
      position: 1
      prefix: --vcf
      valueFrom: $(self.basename)
  - id: vcf_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: VCF folders named in the --vcf file (bgzipped VCFs, one per 
      chromosome, file names containing .chrN.); staged in VCFs/
  - id: guide
    type:
      - 'null'
      - File
    doc: File containing guide RNAs [REQUIRED if --sequence not provided]
    inputBinding:
      position: 1
      prefix: --guide
  - id: sequence
    type:
      - 'null'
      - File
    doc: File with DNA sequences or BED coordinates to extract guides [REQUIRED 
      if --guide not provided]
    inputBinding:
      position: 1
      prefix: --sequence
  - id: pam
    type: File
    doc: File containing the PAM sequence. The file name must follow the 
      CRISPRme pattern <len>-<PAM>-<nuclease>.txt (e.g. 20bp-NGG-SpCas9.txt), 
      because the nuclease name is read from it
    inputBinding:
      position: 1
      prefix: --pam
  - id: be_window
    type:
      - 'null'
      - string
    doc: Window to search for base editor susceptibility (e.g., 4,8)
    inputBinding:
      position: 1
      prefix: --be-window
  - id: be_base
    type:
      - 'null'
      - string
    doc: The base(s) for the chosen base editor (e.g., A,C)
    inputBinding:
      position: 1
      prefix: --be-base
  - id: annotation
    type:
      - 'null'
      - File
    doc: BED file with genome annotations (e.g., regulatory elements, 
      enhancers). The fourth column must contain the annotation name. Must be 
      compressed using bgzip
    inputBinding:
      position: 1
      prefix: --annotation
  - id: personal_annotation
    type:
      - 'null'
      - File
    doc: BED file with personal genomic annotations. The fourth column must 
      contain the annotation name. Must be compressed using bgzip
    inputBinding:
      position: 1
      prefix: --personal_annotation
  - id: samples_id
    type:
      - 'null'
      - File
    doc: File listing sample files (one per line) present in samplesIDs folder;
      staged writable because the pipeline appends to it
    inputBinding:
      position: 1
      prefix: --samplesID
      valueFrom: $(self.basename)
  - id: samples_id_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sample ID files named in the --samplesID list (columns SAMPLE_ID, 
      POPULATION_ID, SUPERPOPULATION_ID, SEX); staged in samplesIDs/
  - id: gene_annotation
    type:
      - 'null'
      - File
    doc: Gene annotation (e.g., GENCODE) to find nearest gene for each target 
      (must be bgzip-compressed)
    inputBinding:
      position: 1
      prefix: --gene_annotation
  - id: mm
    type: int
    doc: Number of mismatches allowed in the search
    inputBinding:
      position: 1
      prefix: --mm
  - id: bdna
    type:
      - 'null'
      - int
    doc: Number of DNA bulges allowed in the search
    inputBinding:
      position: 1
      prefix: --bDNA
  - id: brna
    type:
      - 'null'
      - int
    doc: Number of RNA bulges allowed in the search
    inputBinding:
      position: 1
      prefix: --bRNA
  - id: merge
    type:
      - 'null'
      - int
    doc: Window size (nucleotides) to merge candidate off-targets using the 
      highest scoring as pivot [default 3]
    inputBinding:
      position: 1
      prefix: --merge
  - id: sorting_criteria_scoring
    type:
      - 'null'
      - string
    doc: "Comma-separated list to sort targets by scoring criteria: 'mm', 'bulges',
      or 'mm+bulges' [default: 'mm+bulges']"
    inputBinding:
      position: 1
      prefix: --sorting-criteria-scoring
  - id: sorting_criteria
    type:
      - 'null'
      - string
    doc: "Comma-separated list to sort targets by 'mm', 'bulges', or 'mm+bulges'
      [default: 'mm+bulges,mm']"
    inputBinding:
      position: 1
      prefix: --sorting-criteria
  - id: output
    type: string
    doc: Output folder name; results will be saved in Results/<name>
    inputBinding:
      position: 1
      prefix: --output
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use [default 8]
    inputBinding:
      position: 1
      prefix: --thread
outputs:
  - id: results
    type: Directory
    doc: Results folder Results/<output>
    outputBinding:
      glob: Results/$(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
