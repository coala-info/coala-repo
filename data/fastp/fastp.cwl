cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastp
label: fastp
doc: "fastp is a fast all-in-one FASTQ preprocessor.\n\nTool homepage: https://github.com/OpenGene/fastp"
inputs:
  - id: input_fastq1
    type: File
    doc: Input FASTQ file 1 (unpaired or read 1 of paired-end data)
    inputBinding:
      position: 1
  - id: input_fastq2
    type:
      - 'null'
      - File
    doc: Input FASTQ file 2 (read 2 of paired-end data)
    inputBinding:
      position: 2
  - id: adapter_file
    type:
      - 'null'
      - File
    doc: File containing adapter sequences to trim. Each line should be an 
      adapter sequence.
    inputBinding:
      position: 103
      prefix: --adapter_file
  - id: adapter_file_r2
    type:
      - 'null'
      - File
    doc: File containing adapter sequences for read 2 to trim. Each line should 
      be an adapter sequence.
    inputBinding:
      position: 103
      prefix: --adapter_file_r2
  - id: adapter_sequence
    type:
      - 'null'
      - string
    doc: Adapter sequence to trim. Can be specified multiple times.
    inputBinding:
      position: 103
      prefix: --adapter_sequence
  - id: adapter_sequence_r2
    type:
      - 'null'
      - string
    doc: Adapter sequence for read 2 to trim. Can be specified multiple times.
    inputBinding:
      position: 103
      prefix: --adapter_sequence_r2
  - id: cut_back
    type:
      - 'null'
      - int
    doc: Number of bases to cut from the back of reads.
    default: 0
    inputBinding:
      position: 103
      prefix: --cut_back
  - id: cut_by_quality
    type:
      - 'null'
      - boolean
    doc: Cut reads by quality.
    inputBinding:
      position: 103
      prefix: --cut_by_quality
  - id: cut_by_quality_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold for cutting by quality.
    default: 15
    inputBinding:
      position: 103
      prefix: --cut_by_quality_threshold
  - id: cut_by_quality_window
    type:
      - 'null'
      - int
    doc: Window size for cutting by quality.
    default: 5
    inputBinding:
      position: 103
      prefix: --cut_by_quality_window
  - id: cut_front
    type:
      - 'null'
      - int
    doc: Number of bases to cut from the front of reads.
    default: 0
    inputBinding:
      position: 103
      prefix: --cut_front
  - id: cut_mean_quality
    type:
      - 'null'
      - int
    doc: Cut reads by mean quality. Reads with mean quality below this threshold
      will be discarded.
    default: 0
    inputBinding:
      position: 103
      prefix: --cut_mean_quality
  - id: cut_middle_quality
    type:
      - 'null'
      - int
    doc: Cut reads by middle quality. Reads with middle quality below this 
      threshold will be discarded.
    default: 0
    inputBinding:
      position: 103
      prefix: --cut_middle_quality
  - id: detect_adapter_for_pe
    type:
      - 'null'
      - boolean
    doc: Detect adapter sequences for paired-end data.
    inputBinding:
      position: 103
      prefix: --detect_adapter_for_pe
  - id: detect_adapter_for_se
    type:
      - 'null'
      - boolean
    doc: Detect adapter sequences for single-end data.
    inputBinding:
      position: 103
      prefix: --detect_adapter_for_se
  - id: disable_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: Disable adapter trimming.
    inputBinding:
      position: 103
      prefix: --disable_adapter_trimming
  - id: disable_length_filtering
    type:
      - 'null'
      - boolean
    doc: Disable length filtering.
    inputBinding:
      position: 103
      prefix: --disable_length_filtering
  - id: disable_quality_filtering
    type:
      - 'null'
      - boolean
    doc: Disable quality filtering.
    inputBinding:
      position: 103
      prefix: --disable_quality_filtering
  - id: disable_trim_poly_g
    type:
      - 'null'
      - boolean
    doc: Disable trimming of poly-G tails.
    inputBinding:
      position: 103
      prefix: --disable_trim_poly_g
  - id: disable_trim_poly_t
    type:
      - 'null'
      - boolean
    doc: Disable trimming of poly-T tails.
    inputBinding:
      position: 103
      prefix: --disable_trim_poly_t
  - id: filter_by_index
    type:
      - 'null'
      - boolean
    doc: Filter reads by index.
    inputBinding:
      position: 103
      prefix: --filter_by_index
  - id: length_limit
    type:
      - 'null'
      - int
    doc: The maximum length of a read after trimming to be kept. Reads longer 
      than this will be discarded. If set to -1, no length limit is applied.
    default: -1
    inputBinding:
      position: 103
      prefix: --length_limit
  - id: length_required
    type:
      - 'null'
      - int
    doc: The minimum length of a read after trimming to be kept. Reads shorter 
      than this will be discarded.
    default: 15
    inputBinding:
      position: 103
      prefix: --length_required
  - id: low_complexity_filter
    type:
      - 'null'
      - boolean
    doc: Filter out low-complexity reads.
    inputBinding:
      position: 103
      prefix: --low_complexity_filter
  - id: max_n
    type:
      - 'null'
      - int
    doc: Maximum number of Ns allowed in a read. Reads with more Ns will be 
      discarded.
    default: 0
    inputBinding:
      position: 103
      prefix: --max_n
  - id: merge_diff
    type:
      - 'null'
      - int
    doc: Maximum difference allowed in merging.
    default: 5
    inputBinding:
      position: 103
      prefix: --merge_diff
  - id: merge_diff_percent
    type:
      - 'null'
      - float
    doc: Maximum percentage difference allowed in merging.
    default: 10.0
    inputBinding:
      position: 103
      prefix: --merge_diff_percent
  - id: merge_len
    type:
      - 'null'
      - int
    doc: Minimum overlap length for merging.
    default: 20
    inputBinding:
      position: 103
      prefix: --merge_len
  - id: merge_max_len
    type:
      - 'null'
      - int
    doc: Maximum length of merged reads. If set to 0, no limit.
    default: 0
    inputBinding:
      position: 103
      prefix: --merge_max_len
  - id: merge_only
    type:
      - 'null'
      - boolean
    doc: Only merge overlapping reads, do not perform other trimming.
    inputBinding:
      position: 103
      prefix: --merge_only
  - id: merge_window
    type:
      - 'null'
      - int
    doc: Window size for merging.
    default: 5
    inputBinding:
      position: 103
      prefix: --merge_window
  - id: no_100q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 100.
    inputBinding:
      position: 103
      prefix: --no_100q
  - id: no_101q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 101.
    inputBinding:
      position: 103
      prefix: --no_101q
  - id: no_102q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 102.
    inputBinding:
      position: 103
      prefix: --no_102q
  - id: no_103q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 103.
    inputBinding:
      position: 103
      prefix: --no_103q
  - id: no_104q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 104.
    inputBinding:
      position: 103
      prefix: --no_104q
  - id: no_105q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 105.
    inputBinding:
      position: 103
      prefix: --no_105q
  - id: no_106q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 106.
    inputBinding:
      position: 103
      prefix: --no_106q
  - id: no_107q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 107.
    inputBinding:
      position: 103
      prefix: --no_107q
  - id: no_108q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 108.
    inputBinding:
      position: 103
      prefix: --no_108q
  - id: no_109q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 109.
    inputBinding:
      position: 103
      prefix: --no_109q
  - id: no_10q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 10.
    inputBinding:
      position: 103
      prefix: --no_10q
  - id: no_110q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 110.
    inputBinding:
      position: 103
      prefix: --no_110q
  - id: no_111q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 111.
    inputBinding:
      position: 103
      prefix: --no_111q
  - id: no_112q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 112.
    inputBinding:
      position: 103
      prefix: --no_112q
  - id: no_113q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 113.
    inputBinding:
      position: 103
      prefix: --no_113q
  - id: no_114q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 114.
    inputBinding:
      position: 103
      prefix: --no_114q
  - id: no_115q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 115.
    inputBinding:
      position: 103
      prefix: --no_115q
  - id: no_116q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 116.
    inputBinding:
      position: 103
      prefix: --no_116q
  - id: no_117q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 117.
    inputBinding:
      position: 103
      prefix: --no_117q
  - id: no_118q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 118.
    inputBinding:
      position: 103
      prefix: --no_118q
  - id: no_119q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 119.
    inputBinding:
      position: 103
      prefix: --no_119q
  - id: no_11q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 11.
    inputBinding:
      position: 103
      prefix: --no_11q
  - id: no_120q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 120.
    inputBinding:
      position: 103
      prefix: --no_120q
  - id: no_121q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 121.
    inputBinding:
      position: 103
      prefix: --no_121q
  - id: no_122q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 122.
    inputBinding:
      position: 103
      prefix: --no_122q
  - id: no_123q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 123.
    inputBinding:
      position: 103
      prefix: --no_123q
  - id: no_124q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 124.
    inputBinding:
      position: 103
      prefix: --no_124q
  - id: no_125q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 125.
    inputBinding:
      position: 103
      prefix: --no_125q
  - id: no_126q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 126.
    inputBinding:
      position: 103
      prefix: --no_126q
  - id: no_127q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 127.
    inputBinding:
      position: 103
      prefix: --no_127q
  - id: no_128
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 128.
    inputBinding:
      position: 103
      prefix: --no_128
  - id: no_12q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 12.
    inputBinding:
      position: 103
      prefix: --no_12q
  - id: no_133
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 133.
    inputBinding:
      position: 103
      prefix: --no_133
  - id: no_137
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 137.
    inputBinding:
      position: 103
      prefix: --no_137
  - id: no_13q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 13.
    inputBinding:
      position: 103
      prefix: --no_13q
  - id: no_140
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 140.
    inputBinding:
      position: 103
      prefix: --no_140
  - id: no_141
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 141.
    inputBinding:
      position: 103
      prefix: --no_141
  - id: no_142
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 142.
    inputBinding:
      position: 103
      prefix: --no_142
  - id: no_143
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 143.
    inputBinding:
      position: 103
      prefix: --no_143
  - id: no_144
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 144.
    inputBinding:
      position: 103
      prefix: --no_144
  - id: no_145
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 145.
    inputBinding:
      position: 103
      prefix: --no_145
  - id: no_146
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 146.
    inputBinding:
      position: 103
      prefix: --no_146
  - id: no_147
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 147.
    inputBinding:
      position: 103
      prefix: --no_147
  - id: no_148
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 148.
    inputBinding:
      position: 103
      prefix: --no_148
  - id: no_149
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 149.
    inputBinding:
      position: 103
      prefix: --no_149
  - id: no_14q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 14.
    inputBinding:
      position: 103
      prefix: --no_14q
  - id: no_150
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 150.
    inputBinding:
      position: 103
      prefix: --no_150
  - id: no_151
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 151.
    inputBinding:
      position: 103
      prefix: --no_151
  - id: no_152
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 152.
    inputBinding:
      position: 103
      prefix: --no_152
  - id: no_153
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 153.
    inputBinding:
      position: 103
      prefix: --no_153
  - id: no_154
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 154.
    inputBinding:
      position: 103
      prefix: --no_154
  - id: no_155
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 155.
    inputBinding:
      position: 103
      prefix: --no_155
  - id: no_156
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 156.
    inputBinding:
      position: 103
      prefix: --no_156
  - id: no_157
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 157.
    inputBinding:
      position: 103
      prefix: --no_157
  - id: no_158
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 158.
    inputBinding:
      position: 103
      prefix: --no_158
  - id: no_159
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 159.
    inputBinding:
      position: 103
      prefix: --no_159
  - id: no_15q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 15.
    inputBinding:
      position: 103
      prefix: --no_15q
  - id: no_160
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 160.
    inputBinding:
      position: 103
      prefix: --no_160
  - id: no_161
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 161.
    inputBinding:
      position: 103
      prefix: --no_161
  - id: no_162
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 162.
    inputBinding:
      position: 103
      prefix: --no_162
  - id: no_163
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 163.
    inputBinding:
      position: 103
      prefix: --no_163
  - id: no_164
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 164.
    inputBinding:
      position: 103
      prefix: --no_164
  - id: no_165
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 165.
    inputBinding:
      position: 103
      prefix: --no_165
  - id: no_166
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 166.
    inputBinding:
      position: 103
      prefix: --no_166
  - id: no_167
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 167.
    inputBinding:
      position: 103
      prefix: --no_167
  - id: no_168
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 168.
    inputBinding:
      position: 103
      prefix: --no_168
  - id: no_169
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 169.
    inputBinding:
      position: 103
      prefix: --no_169
  - id: no_16q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 16.
    inputBinding:
      position: 103
      prefix: --no_16q
  - id: no_170
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 170.
    inputBinding:
      position: 103
      prefix: --no_170
  - id: no_171
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 171.
    inputBinding:
      position: 103
      prefix: --no_171
  - id: no_172
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 172.
    inputBinding:
      position: 103
      prefix: --no_172
  - id: no_173
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 173.
    inputBinding:
      position: 103
      prefix: --no_173
  - id: no_174
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 174.
    inputBinding:
      position: 103
      prefix: --no_174
  - id: no_175
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 175.
    inputBinding:
      position: 103
      prefix: --no_175
  - id: no_176
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 176.
    inputBinding:
      position: 103
      prefix: --no_176
  - id: no_177
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 177.
    inputBinding:
      position: 103
      prefix: --no_177
  - id: no_178
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 178.
    inputBinding:
      position: 103
      prefix: --no_178
  - id: no_179
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 179.
    inputBinding:
      position: 103
      prefix: --no_179
  - id: no_17q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 17.
    inputBinding:
      position: 103
      prefix: --no_17q
  - id: no_180
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 180.
    inputBinding:
      position: 103
      prefix: --no_180
  - id: no_181
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 181.
    inputBinding:
      position: 103
      prefix: --no_181
  - id: no_182
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 182.
    inputBinding:
      position: 103
      prefix: --no_182
  - id: no_183
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 183.
    inputBinding:
      position: 103
      prefix: --no_183
  - id: no_184
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 184.
    inputBinding:
      position: 103
      prefix: --no_184
  - id: no_185
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 185.
    inputBinding:
      position: 103
      prefix: --no_185
  - id: no_186
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 186.
    inputBinding:
      position: 103
      prefix: --no_186
  - id: no_187
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 187.
    inputBinding:
      position: 103
      prefix: --no_187
  - id: no_188
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 188.
    inputBinding:
      position: 103
      prefix: --no_188
  - id: no_189
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 189.
    inputBinding:
      position: 103
      prefix: --no_189
  - id: no_18q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 18.
    inputBinding:
      position: 103
      prefix: --no_18q
  - id: no_190
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 190.
    inputBinding:
      position: 103
      prefix: --no_190
  - id: no_191
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 191.
    inputBinding:
      position: 103
      prefix: --no_191
  - id: no_192
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 192.
    inputBinding:
      position: 103
      prefix: --no_192
  - id: no_193
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 193.
    inputBinding:
      position: 103
      prefix: --no_193
  - id: no_194
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 194.
    inputBinding:
      position: 103
      prefix: --no_194
  - id: no_195
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 195.
    inputBinding:
      position: 103
      prefix: --no_195
  - id: no_196
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 196.
    inputBinding:
      position: 103
      prefix: --no_196
  - id: no_197
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 197.
    inputBinding:
      position: 103
      prefix: --no_197
  - id: no_198
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 198.
    inputBinding:
      position: 103
      prefix: --no_198
  - id: no_199
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 199.
    inputBinding:
      position: 103
      prefix: --no_199
  - id: no_19q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 19.
    inputBinding:
      position: 103
      prefix: --no_19q
  - id: no_200
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 200.
    inputBinding:
      position: 103
      prefix: --no_200
  - id: no_201
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 201.
    inputBinding:
      position: 103
      prefix: --no_201
  - id: no_202
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 202.
    inputBinding:
      position: 103
      prefix: --no_202
  - id: no_203
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 203.
    inputBinding:
      position: 103
      prefix: --no_203
  - id: no_204
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 204.
    inputBinding:
      position: 103
      prefix: --no_204
  - id: no_205
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 205.
    inputBinding:
      position: 103
      prefix: --no_205
  - id: no_206
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 206.
    inputBinding:
      position: 103
      prefix: --no_206
  - id: no_207
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 207.
    inputBinding:
      position: 103
      prefix: --no_207
  - id: no_208
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 208.
    inputBinding:
      position: 103
      prefix: --no_208
  - id: no_209
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 209.
    inputBinding:
      position: 103
      prefix: --no_209
  - id: no_20q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 20.
    inputBinding:
      position: 103
      prefix: --no_20q
  - id: no_210
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 210.
    inputBinding:
      position: 103
      prefix: --no_210
  - id: no_211
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 211.
    inputBinding:
      position: 103
      prefix: --no_211
  - id: no_212
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 212.
    inputBinding:
      position: 103
      prefix: --no_212
  - id: no_213
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 213.
    inputBinding:
      position: 103
      prefix: --no_213
  - id: no_214
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 214.
    inputBinding:
      position: 103
      prefix: --no_214
  - id: no_215
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 215.
    inputBinding:
      position: 103
      prefix: --no_215
  - id: no_216
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 216.
    inputBinding:
      position: 103
      prefix: --no_216
  - id: no_217
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 217.
    inputBinding:
      position: 103
      prefix: --no_217
  - id: no_218
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 218.
    inputBinding:
      position: 103
      prefix: --no_218
  - id: no_219
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 219.
    inputBinding:
      position: 103
      prefix: --no_219
  - id: no_21q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 21.
    inputBinding:
      position: 103
      prefix: --no_21q
  - id: no_220
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 220.
    inputBinding:
      position: 103
      prefix: --no_220
  - id: no_221
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 221.
    inputBinding:
      position: 103
      prefix: --no_221
  - id: no_222
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 222.
    inputBinding:
      position: 103
      prefix: --no_222
  - id: no_223
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 223.
    inputBinding:
      position: 103
      prefix: --no_223
  - id: no_224
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 224.
    inputBinding:
      position: 103
      prefix: --no_224
  - id: no_225
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 225.
    inputBinding:
      position: 103
      prefix: --no_225
  - id: no_226
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 226.
    inputBinding:
      position: 103
      prefix: --no_226
  - id: no_227
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 227.
    inputBinding:
      position: 103
      prefix: --no_227
  - id: no_228
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 228.
    inputBinding:
      position: 103
      prefix: --no_228
  - id: no_229
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 229.
    inputBinding:
      position: 103
      prefix: --no_229
  - id: no_22q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 22.
    inputBinding:
      position: 103
      prefix: --no_22q
  - id: no_230
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 230.
    inputBinding:
      position: 103
      prefix: --no_230
  - id: no_231
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 231.
    inputBinding:
      position: 103
      prefix: --no_231
  - id: no_232
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 232.
    inputBinding:
      position: 103
      prefix: --no_232
  - id: no_233
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 233.
    inputBinding:
      position: 103
      prefix: --no_233
  - id: no_234
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 234.
    inputBinding:
      position: 103
      prefix: --no_234
  - id: no_235
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 235.
    inputBinding:
      position: 103
      prefix: --no_235
  - id: no_236
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 236.
    inputBinding:
      position: 103
      prefix: --no_236
  - id: no_237
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 237.
    inputBinding:
      position: 103
      prefix: --no_237
  - id: no_238
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 238.
    inputBinding:
      position: 103
      prefix: --no_238
  - id: no_239
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 239.
    inputBinding:
      position: 103
      prefix: --no_239
  - id: no_23q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 23.
    inputBinding:
      position: 103
      prefix: --no_23q
  - id: no_240
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 240.
    inputBinding:
      position: 103
      prefix: --no_240
  - id: no_241
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 241.
    inputBinding:
      position: 103
      prefix: --no_241
  - id: no_242
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 242.
    inputBinding:
      position: 103
      prefix: --no_242
  - id: no_243
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 243.
    inputBinding:
      position: 103
      prefix: --no_243
  - id: no_244
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 244.
    inputBinding:
      position: 103
      prefix: --no_244
  - id: no_245
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 245.
    inputBinding:
      position: 103
      prefix: --no_245
  - id: no_246
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 246.
    inputBinding:
      position: 103
      prefix: --no_246
  - id: no_247
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 247.
    inputBinding:
      position: 103
      prefix: --no_247
  - id: no_248
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 248.
    inputBinding:
      position: 103
      prefix: --no_248
  - id: no_249
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 249.
    inputBinding:
      position: 103
      prefix: --no_249
  - id: no_24q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 24.
    inputBinding:
      position: 103
      prefix: --no_24q
  - id: no_250
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 250.
    inputBinding:
      position: 103
      prefix: --no_250
  - id: no_251
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 251.
    inputBinding:
      position: 103
      prefix: --no_251
  - id: no_252
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 252.
    inputBinding:
      position: 103
      prefix: --no_252
  - id: no_253
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 253.
    inputBinding:
      position: 103
      prefix: --no_253
  - id: no_254
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 254.
    inputBinding:
      position: 103
      prefix: --no_254
  - id: no_255
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 255.
    inputBinding:
      position: 103
      prefix: --no_255
  - id: no_25q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 25.
    inputBinding:
      position: 103
      prefix: --no_25q
  - id: no_26q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 26.
    inputBinding:
      position: 103
      prefix: --no_26q
  - id: no_27q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 27.
    inputBinding:
      position: 103
      prefix: --no_27q
  - id: no_28q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 28.
    inputBinding:
      position: 103
      prefix: --no_28q
  - id: no_29q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 29.
    inputBinding:
      position: 103
      prefix: --no_29q
  - id: no_30q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 30.
    inputBinding:
      position: 103
      prefix: --no_30q
  - id: no_31q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 31.
    inputBinding:
      position: 103
      prefix: --no_31q
  - id: no_32q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 32.
    inputBinding:
      position: 103
      prefix: --no_32q
  - id: no_33q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 33.
    inputBinding:
      position: 103
      prefix: --no_33q
  - id: no_34q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 34.
    inputBinding:
      position: 103
      prefix: --no_34q
  - id: no_35q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 35.
    inputBinding:
      position: 103
      prefix: --no_35q
  - id: no_36q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 36.
    inputBinding:
      position: 103
      prefix: --no_36q
  - id: no_37q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 37.
    inputBinding:
      position: 103
      prefix: --no_37q
  - id: no_38q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 38.
    inputBinding:
      position: 103
      prefix: --no_38q
  - id: no_39q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 39.
    inputBinding:
      position: 103
      prefix: --no_39q
  - id: no_40q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 40.
    inputBinding:
      position: 103
      prefix: --no_40q
  - id: no_41q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 41.
    inputBinding:
      position: 103
      prefix: --no_41q
  - id: no_42q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 42.
    inputBinding:
      position: 103
      prefix: --no_42q
  - id: no_43q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 43.
    inputBinding:
      position: 103
      prefix: --no_43q
  - id: no_44q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 44.
    inputBinding:
      position: 103
      prefix: --no_44q
  - id: no_45q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 45.
    inputBinding:
      position: 103
      prefix: --no_45q
  - id: no_46q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 46.
    inputBinding:
      position: 103
      prefix: --no_46q
  - id: no_47q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 47.
    inputBinding:
      position: 103
      prefix: --no_47q
  - id: no_48q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 48.
    inputBinding:
      position: 103
      prefix: --no_48q
  - id: no_49q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 49.
    inputBinding:
      position: 103
      prefix: --no_49q
  - id: no_50q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 50.
    inputBinding:
      position: 103
      prefix: --no_50q
  - id: no_51q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 51.
    inputBinding:
      position: 103
      prefix: --no_51q
  - id: no_52q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 52.
    inputBinding:
      position: 103
      prefix: --no_52q
  - id: no_53q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 53.
    inputBinding:
      position: 103
      prefix: --no_53q
  - id: no_54q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 54.
    inputBinding:
      position: 103
      prefix: --no_54q
  - id: no_55q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 55.
    inputBinding:
      position: 103
      prefix: --no_55q
  - id: no_56q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 56.
    inputBinding:
      position: 103
      prefix: --no_56q
  - id: no_57q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 57.
    inputBinding:
      position: 103
      prefix: --no_57q
  - id: no_58q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 58.
    inputBinding:
      position: 103
      prefix: --no_58q
  - id: no_59q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 59.
    inputBinding:
      position: 103
      prefix: --no_59q
  - id: no_5q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 5.
    inputBinding:
      position: 103
      prefix: --no_5q
  - id: no_60q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 60.
    inputBinding:
      position: 103
      prefix: --no_60q
  - id: no_61q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 61.
    inputBinding:
      position: 103
      prefix: --no_61q
  - id: no_62q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 62.
    inputBinding:
      position: 103
      prefix: --no_62q
  - id: no_63q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 63.
    inputBinding:
      position: 103
      prefix: --no_63q
  - id: no_64q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 64.
    inputBinding:
      position: 103
      prefix: --no_64q
  - id: no_65q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 65.
    inputBinding:
      position: 103
      prefix: --no_65q
  - id: no_66q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 66.
    inputBinding:
      position: 103
      prefix: --no_66q
  - id: no_67q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 67.
    inputBinding:
      position: 103
      prefix: --no_67q
  - id: no_68q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 68.
    inputBinding:
      position: 103
      prefix: --no_68q
  - id: no_69q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 69.
    inputBinding:
      position: 103
      prefix: --no_69q
  - id: no_6q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 6.
    inputBinding:
      position: 103
      prefix: --no_6q
  - id: no_70q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 70.
    inputBinding:
      position: 103
      prefix: --no_70q
  - id: no_71q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 71.
    inputBinding:
      position: 103
      prefix: --no_71q
  - id: no_72q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 72.
    inputBinding:
      position: 103
      prefix: --no_72q
  - id: no_73q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 73.
    inputBinding:
      position: 103
      prefix: --no_73q
  - id: no_74q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 74.
    inputBinding:
      position: 103
      prefix: --no_74q
  - id: no_75q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 75.
    inputBinding:
      position: 103
      prefix: --no_75q
  - id: no_76q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 76.
    inputBinding:
      position: 103
      prefix: --no_76q
  - id: no_77q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 77.
    inputBinding:
      position: 103
      prefix: --no_77q
  - id: no_78q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 78.
    inputBinding:
      position: 103
      prefix: --no_78q
  - id: no_79q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 79.
    inputBinding:
      position: 103
      prefix: --no_79q
  - id: no_7q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 7.
    inputBinding:
      position: 103
      prefix: --no_7q
  - id: no_80q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 80.
    inputBinding:
      position: 103
      prefix: --no_80q
  - id: no_81q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 81.
    inputBinding:
      position: 103
      prefix: --no_81q
  - id: no_82q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 82.
    inputBinding:
      position: 103
      prefix: --no_82q
  - id: no_83q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 83.
    inputBinding:
      position: 103
      prefix: --no_83q
  - id: no_84q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 84.
    inputBinding:
      position: 103
      prefix: --no_84q
  - id: no_85q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 85.
    inputBinding:
      position: 103
      prefix: --no_85q
  - id: no_86q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 86.
    inputBinding:
      position: 103
      prefix: --no_86q
  - id: no_87q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 87.
    inputBinding:
      position: 103
      prefix: --no_87q
  - id: no_88q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 88.
    inputBinding:
      position: 103
      prefix: --no_88q
  - id: no_89q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 89.
    inputBinding:
      position: 103
      prefix: --no_89q
  - id: no_8q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 8.
    inputBinding:
      position: 103
      prefix: --no_8q
  - id: no_90q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 90.
    inputBinding:
      position: 103
      prefix: --no_90q
  - id: no_91q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 91.
    inputBinding:
      position: 103
      prefix: --no_91q
  - id: no_92q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 92.
    inputBinding:
      position: 103
      prefix: --no_92q
  - id: no_93q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 93.
    inputBinding:
      position: 103
      prefix: --no_93q
  - id: no_94q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 94.
    inputBinding:
      position: 103
      prefix: --no_94q
  - id: no_95q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 95.
    inputBinding:
      position: 103
      prefix: --no_95q
  - id: no_96q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 96.
    inputBinding:
      position: 103
      prefix: --no_96q
  - id: no_97q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 97.
    inputBinding:
      position: 103
      prefix: --no_97q
  - id: no_98q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 98.
    inputBinding:
      position: 103
      prefix: --no_98q
  - id: no_99q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 99.
    inputBinding:
      position: 103
      prefix: --no_99q
  - id: no_9q
    type:
      - 'null'
      - boolean
    doc: Do not use quality values >= 9.
    inputBinding:
      position: 103
      prefix: --no_9q
  - id: overlap_diff
    type:
      - 'null'
      - int
    doc: Maximum difference allowed in overlap.
    default: 5
    inputBinding:
      position: 103
      prefix: --overlap_diff
  - id: overlap_diff_percent
    type:
      - 'null'
      - float
    doc: Maximum percentage difference allowed in overlap.
    default: 10.0
    inputBinding:
      position: 103
      prefix: --overlap_diff_percent
  - id: overlap_in_usearch
    type:
      - 'null'
      - boolean
    doc: Use Usearch for overlap detection.
    inputBinding:
      position: 103
      prefix: --overlap_in_usearch
  - id: overlap_len
    type:
      - 'null'
      - int
    doc: Minimum overlap length for Usearch.
    default: 20
    inputBinding:
      position: 103
      prefix: --overlap_len
  - id: overlap_window
    type:
      - 'null'
      - int
    doc: Window size for overlap detection.
    default: 5
    inputBinding:
      position: 103
      prefix: --overlap_window
  - id: qualified_quality_threshold
    type:
      - 'null'
      - int
    doc: The minimum quality score for a base to be considered qualified. Bases 
      with quality scores below this threshold will be trimmed.
    default: 15
    inputBinding:
      position: 103
      prefix: --qualified_quality_threshold
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 0
    inputBinding:
      position: 103
      prefix: --thread
  - id: trim_back
    type:
      - 'null'
      - int
    doc: Number of bases to trim from the back of reads.
    default: 0
    inputBinding:
      position: 103
      prefix: --trim_back
  - id: trim_back_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold for trimming from the back.
    default: 15
    inputBinding:
      position: 103
      prefix: --trim_back_threshold
  - id: trim_back_window
    type:
      - 'null'
      - int
    doc: Window size for trimming from the back.
    default: 5
    inputBinding:
      position: 103
      prefix: --trim_back_window
  - id: trim_front
    type:
      - 'null'
      - int
    doc: Number of bases to trim from the front of reads.
    default: 0
    inputBinding:
      position: 103
      prefix: --trim_front
  - id: trim_front_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold for trimming from the front.
    default: 15
    inputBinding:
      position: 103
      prefix: --trim_front_threshold
  - id: trim_front_window
    type:
      - 'null'
      - int
    doc: Window size for trimming from the front.
    default: 5
    inputBinding:
      position: 103
      prefix: --trim_front_window
  - id: trim_poly_g
    type:
      - 'null'
      - boolean
    doc: Trim poly-G tails.
    inputBinding:
      position: 103
      prefix: --trim_poly_g
  - id: trim_poly_t
    type:
      - 'null'
      - boolean
    doc: Trim poly-T tails.
    inputBinding:
      position: 103
      prefix: --trim_poly_t
  - id: umi
    type:
      - 'null'
      - boolean
    doc: Enable UMI processing.
    inputBinding:
      position: 103
      prefix: --umi
  - id: umi_barcode_len
    type:
      - 'null'
      - int
    doc: Length of UMI barcode.
    default: 0
    inputBinding:
      position: 103
      prefix: --umi_barcode_len
  - id: umi_barcode_loc
    type:
      - 'null'
      - string
    doc: Location of UMI barcode (e.g., 'read1_fwd', 'read1_rev', 'read2_fwd', 
      'read2_rev', 'any').
    default: any
    inputBinding:
      position: 103
      prefix: --umi_barcode_loc
  - id: umi_barcode_prefix
    type:
      - 'null'
      - boolean
    doc: Add UMI barcode as prefix to read name.
    inputBinding:
      position: 103
      prefix: --umi_barcode_prefix
  - id: umi_len
    type:
      - 'null'
      - int
    doc: Length of UMI.
    default: 0
    inputBinding:
      position: 103
      prefix: --umi_len
  - id: umi_loc
    type:
      - 'null'
      - string
    doc: Location of UMI (e.g., 'read1_fwd', 'read1_rev', 'read2_fwd', 
      'read2_rev', 'any').
    default: any
    inputBinding:
      position: 103
      prefix: --umi_loc
  - id: umi_prefix
    type:
      - 'null'
      - boolean
    doc: Add UMI as prefix to read name.
    inputBinding:
      position: 103
      prefix: --umi_prefix
outputs:
  - id: output_fastq1
    type:
      - 'null'
      - File
    doc: Output FASTQ file 1 (unpaired or read 1 of paired-end data). If not 
      specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_fastq1)
  - id: output_fastq2
    type:
      - 'null'
      - File
    doc: Output FASTQ file 2 (read 2 of paired-end data). If not specified, 
      output to stdout.
    outputBinding:
      glob: $(inputs.output_fastq2)
  - id: output_json
    type:
      - 'null'
      - File
    doc: Output JSON report file. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_json)
  - id: output_html
    type:
      - 'null'
      - File
    doc: Output HTML report file. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastp:1.1.0--heae3180_0
