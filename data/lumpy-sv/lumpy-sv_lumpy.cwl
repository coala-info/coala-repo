cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy
label: lumpy-sv_lumpy
doc: "LUMPY: find structural variants from paired-end, split-read and BEDPE evidence. The sr, pe and bedpe inputs are records that are passed to lumpy as comma-separated key:value strings.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome file (defines chromosome order)
    inputBinding:
      position: 1
      prefix: -g
  - id: show_evidence
    type:
      - 'null'
      - boolean
    doc: Show evidence for each call
    inputBinding:
      position: 1
      prefix: -e
  - id: window_size
    type:
      - 'null'
      - int
    doc: File read windows size (default 1000000)
    inputBinding:
      position: 1
      prefix: -w
  - id: min_weight
    type:
      - 'null'
      - int
    doc: Minimum weight for a call
    inputBinding:
      position: 1
      prefix: -mw
  - id: min_sample_weight
    type:
      - 'null'
      - int
    doc: Minimum per-sample weight for a call
    inputBinding:
      position: 1
      prefix: -msw
  - id: trim_threshold
    type:
      - 'null'
      - float
    doc: Trim threshold
    inputBinding:
      position: 1
      prefix: -tt
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: Exclude file (BED)
    inputBinding:
      position: 1
      prefix: -x
  - id: temp_prefix
    type:
      - 'null'
      - string
    doc: Temp file prefix, must be to a writeable directory
    inputBinding:
      position: 1
      prefix: -t
  - id: probability_curve
    type:
      - 'null'
      - boolean
    doc: Output probability curve for each variant
    inputBinding:
      position: 1
      prefix: -P
  - id: bedpe_output
    type:
      - 'null'
      - boolean
    doc: Output BEDPE instead of VCF
    inputBinding:
      position: 1
      prefix: -b
  - id: split_read_evidence
    type:
      - 'null'
      - type: record
        name: lumpy_sr
        fields:
          - name: bam_file
            type: File
          - name: id
            type: ['null', string]
          - name: back_distance
            type: ['null', int]
          - name: min_mapping_threshold
            type: ['null', int]
          - name: weight
            type: ['null', int]
          - name: min_clip
            type: ['null', int]
          - name: read_group
            type: ['null', string]
    doc: Split-read evidence (-sr); fields bam_file, id, back_distance, min_mapping_threshold, weight, min_clip, read_group
    inputBinding:
      position: 2
      prefix: -sr
      valueFrom: |
        ${
          var keys = ["bam_file", "id", "back_distance", "min_mapping_threshold", "weight", "min_clip", "read_group"];
          var parts = [];
          keys.forEach(function(k) {
            var v = self[k];
            if (v !== null && v !== undefined) {
              parts.push(k + ":" + (v.path ? v.path : v));
            }
          });
          return parts.join(",");
        }
  - id: paired_end_evidence
    type:
      - 'null'
      - type: record
        name: lumpy_pe
        fields:
          - name: bam_file
            type: File
          - name: id
            type: ['null', string]
          - name: histo_file
            type: ['null', File]
          - name: mean
            type: ['null', float]
          - name: stdev
            type: ['null', float]
          - name: read_length
            type: ['null', int]
          - name: min_non_overlap
            type: ['null', int]
          - name: discordant_z
            type: ['null', float]
          - name: back_distance
            type: ['null', int]
          - name: min_mapping_threshold
            type: ['null', int]
          - name: weight
            type: ['null', int]
          - name: read_group
            type: ['null', string]
    doc: Paired-end evidence (-pe); fields bam_file, id, histo_file, mean, stdev, read_length, min_non_overlap, discordant_z, back_distance, min_mapping_threshold, weight, read_group
    inputBinding:
      position: 3
      prefix: -pe
      valueFrom: |
        ${
          var keys = ["bam_file", "id", "histo_file", "mean", "stdev", "read_length", "min_non_overlap", "discordant_z", "back_distance", "min_mapping_threshold", "weight", "read_group"];
          var parts = [];
          keys.forEach(function(k) {
            var v = self[k];
            if (v !== null && v !== undefined) {
              parts.push(k + ":" + (v.path ? v.path : v));
            }
          });
          return parts.join(",");
        }
  - id: bedpe_evidence
    type:
      - 'null'
      - type: record
        name: lumpy_bedpe
        fields:
          - name: bedpe_file
            type: File
          - name: id
            type: ['null', string]
          - name: weight
            type: ['null', int]
    doc: BEDPE evidence (-bedpe); fields bedpe_file, id, weight
    inputBinding:
      position: 4
      prefix: -bedpe
      valueFrom: |
        ${
          var keys = ["bedpe_file", "id", "weight"];
          var parts = [];
          keys.forEach(function(k) {
            var v = self[k];
            if (v !== null && v !== undefined) {
              parts.push(k + ":" + (v.path ? v.path : v));
            }
          });
          return parts.join(",");
        }
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that receives the calls (standard output); default lumpy_calls.out
outputs:
  - id: calls
    type: stdout
    doc: Structural variant calls (VCF, or BEDPE with bedpe_output)
stdout: "$(inputs.output_name ? inputs.output_name : 'lumpy_calls.out')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
