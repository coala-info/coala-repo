cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffmpeg
label: ffmpeg
doc: "Universal media converter\n\nTool homepage: https://github.com/FFmpeg/FFmpeg"
inputs:
  - id: input_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Input file options
    inputBinding:
      position: 1
  - id: infile
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file
    inputBinding:
      position: 2
  - id: output_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Output file options
    inputBinding:
      position: 3
  - id: acodec
    type:
      - 'null'
      - string
    doc: alias for -c:a (select encoder/decoder for audio streams)
    inputBinding:
      position: 104
      prefix: -acodec
  - id: af
    type:
      - 'null'
      - string
    doc: alias for -filter:a (apply filters to audio streams)
    inputBinding:
      position: 104
      prefix: -af
  - id: aspect_ratio
    type:
      - 'null'
      - type: array
        items: string
    doc: set aspect ratio (4:3, 16:9 or 1.3333, 1.7777)
    inputBinding:
      position: 104
      prefix: -aspect
  - id: audio_bitrate
    type:
      - 'null'
      - string
    doc: alias for -b:a (select bitrate for audio streams)
    inputBinding:
      position: 104
      prefix: -ab
  - id: audio_channels
    type:
      - 'null'
      - type: array
        items: string
    doc: set number of audio channels
    inputBinding:
      position: 104
      prefix: -ac
  - id: audio_quality
    type:
      - 'null'
      - string
    doc: set audio quality (codec-specific)
    inputBinding:
      position: 104
      prefix: -aq
  - id: audio_sampling_rate
    type:
      - 'null'
      - type: array
        items: string
    doc: set audio sampling rate (in Hz)
    inputBinding:
      position: 104
      prefix: -ar
  - id: codec
    type:
      - 'null'
      - type: array
        items: string
    doc: select encoder/decoder ('copy' to copy stream without reencoding)
    inputBinding:
      position: 104
      prefix: -c
  - id: decoders
    type:
      - 'null'
      - boolean
    doc: show available decoders
    inputBinding:
      position: 104
  - id: demuxers
    type:
      - 'null'
      - boolean
    doc: show available demuxers
    inputBinding:
      position: 104
  - id: devices
    type:
      - 'null'
      - boolean
    doc: show available devices
    inputBinding:
      position: 104
  - id: disable_audio
    type:
      - 'null'
      - boolean
    doc: disable audio
    inputBinding:
      position: 104
      prefix: -an
  - id: disable_subtitle
    type:
      - 'null'
      - boolean
    doc: disable subtitle
    inputBinding:
      position: 104
      prefix: -sn
  - id: disable_video
    type:
      - 'null'
      - boolean
    doc: disable video
    inputBinding:
      position: 104
      prefix: -vn
  - id: duration
    type:
      - 'null'
      - string
    doc: stop transcoding after specified duration
    inputBinding:
      position: 104
      prefix: -t
  - id: encoders
    type:
      - 'null'
      - boolean
    doc: show available encoders
    inputBinding:
      position: 104
  - id: filter_graph
    type:
      - 'null'
      - type: array
        items: string
    doc: apply specified filters to audio/video
    inputBinding:
      position: 104
      prefix: -filter
  - id: filters
    type:
      - 'null'
      - boolean
    doc: show available filters
    inputBinding:
      position: 104
  - id: format
    type:
      - 'null'
      - string
    doc: force container format (auto-detected otherwise)
    inputBinding:
      position: 104
      prefix: -f
  - id: framerate
    type:
      - 'null'
      - type: array
        items: string
    doc: override input framerate/convert to given output framerate (Hz value, 
      fraction or abbreviation)
    inputBinding:
      position: 104
      prefix: -r
  - id: layouts
    type:
      - 'null'
      - boolean
    doc: show standard channel layouts
    inputBinding:
      position: 104
  - id: license
    type:
      - 'null'
      - boolean
    doc: show license
    inputBinding:
      position: 104
      prefix: -L
  - id: loglevel
    type:
      - 'null'
      - string
    doc: set logging level
    inputBinding:
      position: 104
      prefix: -v
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: add metadata
    inputBinding:
      position: 104
      prefix: -metadata
  - id: muxers
    type:
      - 'null'
      - boolean
    doc: show available muxers
    inputBinding:
      position: 104
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: never overwrite output files
    inputBinding:
      position: 104
      prefix: -n
  - id: overwrite_output
    type:
      - 'null'
      - boolean
    doc: overwrite output files
    inputBinding:
      position: 104
      prefix: -y
  - id: pix_fmts
    type:
      - 'null'
      - boolean
    doc: show available pixel formats
    inputBinding:
      position: 104
  - id: sample_fmts
    type:
      - 'null'
      - boolean
    doc: show available audio sample formats
    inputBinding:
      position: 104
  - id: scodec
    type:
      - 'null'
      - string
    doc: alias for -c:s (select encoder/decoder for subtitle streams)
    inputBinding:
      position: 104
      prefix: -scodec
  - id: start_time
    type:
      - 'null'
      - string
    doc: start transcoding at specified time
    inputBinding:
      position: 104
      prefix: -ss
  - id: stats
    type:
      - 'null'
      - boolean
    doc: print progress report during encoding
    inputBinding:
      position: 104
  - id: stop_time
    type:
      - 'null'
      - string
    doc: stop transcoding after specified time is reached
    inputBinding:
      position: 104
      prefix: -to
  - id: vcodec
    type:
      - 'null'
      - string
    doc: alias for -c:v (select encoder/decoder for video streams)
    inputBinding:
      position: 104
      prefix: -vcodec
  - id: vf
    type:
      - 'null'
      - string
    doc: alias for -filter:v (apply filters to video streams)
    inputBinding:
      position: 104
      prefix: -vf
  - id: video_bitrate
    type:
      - 'null'
      - string
    doc: video bitrate (please use -b:v)
    inputBinding:
      position: 104
      prefix: -b
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffmpeg:7.1.1
