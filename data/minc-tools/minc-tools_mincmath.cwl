cwlVersion: v1.2
class: CommandLineTool
baseCommand: mincmath
label: mincmath
doc: "Perform math operations on MINC volumes (add, subtract, scale, compare, count\
  \ and more) voxel by voxel.\n\nTool homepage: https://github.com/BIC-MNI/minc-tools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input MINC volumes (in1.mnc ...)
    inputBinding:
      position: 90
  - id: output_file_path
    type: string
    doc: Name of the output MINC file (out.mnc)
    inputBinding:
      position: 91
  - id: minc2
    type:
      - 'null'
      - boolean
    doc: 'Produce a MINC 2.0 format output file'
    inputBinding:
      position: 1
      prefix: '-2'
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: 'Overwrite existing file.'
    inputBinding:
      position: 1
      prefix: '-clobber'
  - id: noclobber
    type:
      - 'null'
      - boolean
    doc: 'Don''t overwrite existing file (default).'
    inputBinding:
      position: 1
      prefix: '-noclobber'
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: 'Synonym for -noclobber.'
    inputBinding:
      position: 1
      prefix: '-no_clobber'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print out log messages (default).'
    inputBinding:
      position: 1
      prefix: '-verbose'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not print out log messages.'
    inputBinding:
      position: 1
      prefix: '-quiet'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Print out debugging messages.'
    inputBinding:
      position: 1
      prefix: '-debug'
  - id: copy_header
    type:
      - 'null'
      - boolean
    doc: 'Copy all of the header from the first file.'
    inputBinding:
      position: 1
      prefix: '-copy_header'
  - id: nocopy_header
    type:
      - 'null'
      - boolean
    doc: 'Do not copy all of the header from the first file.'
    inputBinding:
      position: 1
      prefix: '-nocopy_header'
  - id: filetype
    type:
      - 'null'
      - boolean
    doc: 'Use data type of first file (default).'
    inputBinding:
      position: 1
      prefix: '-filetype'
  - id: byte
    type:
      - 'null'
      - boolean
    doc: 'Write out byte data.'
    inputBinding:
      position: 1
      prefix: '-byte'
  - id: short
    type:
      - 'null'
      - boolean
    doc: 'Write out short integer data.'
    inputBinding:
      position: 1
      prefix: '-short'
  - id: int
    type:
      - 'null'
      - boolean
    doc: 'Write out 32-bit integer data.'
    inputBinding:
      position: 1
      prefix: '-int'
  - id: long
    type:
      - 'null'
      - boolean
    doc: 'Superseded by -int.'
    inputBinding:
      position: 1
      prefix: '-long'
  - id: float
    type:
      - 'null'
      - boolean
    doc: 'Write out single-precision floating-point data.'
    inputBinding:
      position: 1
      prefix: '-float'
  - id: double
    type:
      - 'null'
      - boolean
    doc: 'Write out double-precision floating-point data.'
    inputBinding:
      position: 1
      prefix: '-double'
  - id: signed
    type:
      - 'null'
      - boolean
    doc: 'Write signed integer data.'
    inputBinding:
      position: 1
      prefix: '-signed'
  - id: unsigned
    type:
      - 'null'
      - boolean
    doc: 'Write unsigned integer data (default if type specified).'
    inputBinding:
      position: 1
      prefix: '-unsigned'
  - id: check_dimensions
    type:
      - 'null'
      - boolean
    doc: 'Check that files have matching dimensions (default).'
    inputBinding:
      position: 1
      prefix: '-check_dimensions'
  - id: nocheck_dimensions
    type:
      - 'null'
      - boolean
    doc: 'Do not check that files have matching dimensions.'
    inputBinding:
      position: 1
      prefix: '-nocheck_dimensions'
  - id: ignore_nan
    type:
      - 'null'
      - boolean
    doc: 'Ignore invalid data (NaN) for accumulations.'
    inputBinding:
      position: 1
      prefix: '-ignore_nan'
  - id: propagate_nan
    type:
      - 'null'
      - boolean
    doc: 'Invalid data in any file at a voxel produces a NaN (default).'
    inputBinding:
      position: 1
      prefix: '-propagate_nan'
  - id: nan
    type:
      - 'null'
      - boolean
    doc: 'Output NaN when an illegal operation is done (default).'
    inputBinding:
      position: 1
      prefix: '-nan'
  - id: zero
    type:
      - 'null'
      - boolean
    doc: 'Output zero when an illegal operation is done.'
    inputBinding:
      position: 1
      prefix: '-zero'
  - id: filelist
    type:
      - 'null'
      - File
    doc: 'Specify the name of a file containing input file names (- for stdin).'
    inputBinding:
      position: 1
      prefix: '-filelist'
  - id: range
    type:
      - 'null'
      - type: array
        items: double
    doc: 'Valid range for output data. Two values (min max).'
    inputBinding:
      position: 1
      prefix: '-range'
  - id: max_buffer_size_in_kb
    type:
      - 'null'
      - int
    doc: 'Specify the maximum size of the internal buffers (in kbytes). Default 4096.'
    inputBinding:
      position: 1
      prefix: '-max_buffer_size_in_kb'
  - id: dimension
    type:
      - 'null'
      - string
    doc: 'Specify a dimension along which we wish to perform a calculation.'
    inputBinding:
      position: 1
      prefix: '-dimension'
  - id: illegal_value
    type:
      - 'null'
      - double
    doc: 'Value to write out when an illegal operation is done.'
    inputBinding:
      position: 1
      prefix: '-illegal_value'
  - id: constant
    type:
      - 'null'
      - double
    doc: 'Specify a constant argument.'
    inputBinding:
      position: 1
      prefix: '-constant'
  - id: const
    type:
      - 'null'
      - double
    doc: 'Synonym for -constant.'
    inputBinding:
      position: 1
      prefix: '-const'
  - id: const2
    type:
      - 'null'
      - type: array
        items: double
    doc: 'Specify two constant arguments.'
    inputBinding:
      position: 1
      prefix: '-const2'
  - id: add
    type:
      - 'null'
      - boolean
    doc: 'Add N volumes or volume + constant.'
    inputBinding:
      position: 1
      prefix: '-add'
  - id: sub
    type:
      - 'null'
      - boolean
    doc: 'Subtract 2 volumes or volume - constant.'
    inputBinding:
      position: 1
      prefix: '-sub'
  - id: mult
    type:
      - 'null'
      - boolean
    doc: 'Multiply N volumes or volume * constant.'
    inputBinding:
      position: 1
      prefix: '-mult'
  - id: div
    type:
      - 'null'
      - boolean
    doc: 'Divide 2 volumes or volume / constant.'
    inputBinding:
      position: 1
      prefix: '-div'
  - id: invert
    type:
      - 'null'
      - boolean
    doc: 'Calculate 1/x at each voxel (use -constant for c/x).'
    inputBinding:
      position: 1
      prefix: '-invert'
  - id: sqrt
    type:
      - 'null'
      - boolean
    doc: 'Take square root of a volume.'
    inputBinding:
      position: 1
      prefix: '-sqrt'
  - id: square
    type:
      - 'null'
      - boolean
    doc: 'Take square of a volume.'
    inputBinding:
      position: 1
      prefix: '-square'
  - id: abs
    type:
      - 'null'
      - boolean
    doc: 'Take absolute value of a volume.'
    inputBinding:
      position: 1
      prefix: '-abs'
  - id: max
    type:
      - 'null'
      - boolean
    doc: 'Synonym for -maximum.'
    inputBinding:
      position: 1
      prefix: '-max'
  - id: maximum
    type:
      - 'null'
      - boolean
    doc: 'Find maximum of N volumes.'
    inputBinding:
      position: 1
      prefix: '-maximum'
  - id: minimum
    type:
      - 'null'
      - boolean
    doc: 'Find minimum of N volumes.'
    inputBinding:
      position: 1
      prefix: '-minimum'
  - id: exp
    type:
      - 'null'
      - boolean
    doc: 'Calculate c2*exp(c1*x). The constants c1 and c2 default to 1.'
    inputBinding:
      position: 1
      prefix: '-exp'
  - id: log
    type:
      - 'null'
      - boolean
    doc: 'Calculate log(x/c2)/c1. The constants c1 and c2 default to 1.'
    inputBinding:
      position: 1
      prefix: '-log'
  - id: scale
    type:
      - 'null'
      - boolean
    doc: 'Scale a volume: volume * c1 + c2.'
    inputBinding:
      position: 1
      prefix: '-scale'
  - id: clamp
    type:
      - 'null'
      - boolean
    doc: 'Clamp a volume to lie between two values.'
    inputBinding:
      position: 1
      prefix: '-clamp'
  - id: segment
    type:
      - 'null'
      - boolean
    doc: 'Segment a volume using range of -const2: within range = 1, outside range = 0.'
    inputBinding:
      position: 1
      prefix: '-segment'
  - id: nsegment
    type:
      - 'null'
      - boolean
    doc: 'Opposite of -segment: within range = 0, outside range = 1.'
    inputBinding:
      position: 1
      prefix: '-nsegment'
  - id: percentdiff
    type:
      - 'null'
      - boolean
    doc: 'Percent difference between 2 volumes, thresholded (const def=0.0).'
    inputBinding:
      position: 1
      prefix: '-percentdiff'
  - id: pd
    type:
      - 'null'
      - boolean
    doc: 'Synonym for -percentdiff.'
    inputBinding:
      position: 1
      prefix: '-pd'
  - id: eq
    type:
      - 'null'
      - boolean
    doc: 'Test for integer vol1 == vol2 or vol1 == const.'
    inputBinding:
      position: 1
      prefix: '-eq'
  - id: ne
    type:
      - 'null'
      - boolean
    doc: 'Test for integer vol1 != vol2 or vol1 != const.'
    inputBinding:
      position: 1
      prefix: '-ne'
  - id: gt
    type:
      - 'null'
      - boolean
    doc: 'Test for vol1 > vol2 or vol1 > const.'
    inputBinding:
      position: 1
      prefix: '-gt'
  - id: ge
    type:
      - 'null'
      - boolean
    doc: 'Test for vol1 >= vol2 or vol1 >= const.'
    inputBinding:
      position: 1
      prefix: '-ge'
  - id: lt
    type:
      - 'null'
      - boolean
    doc: 'Test for vol1 < vol2 or vol1 < const.'
    inputBinding:
      position: 1
      prefix: '-lt'
  - id: le
    type:
      - 'null'
      - boolean
    doc: 'Test for vol1 <= vol2 or vol1 <= const.'
    inputBinding:
      position: 1
      prefix: '-le'
  - id: op_and
    type:
      - 'null'
      - boolean
    doc: 'Calculate vol1 && vol2 (&& ...).'
    inputBinding:
      position: 1
      prefix: '-and'
  - id: op_or
    type:
      - 'null'
      - boolean
    doc: 'Calculate vol1 || vol2 (|| ...).'
    inputBinding:
      position: 1
      prefix: '-or'
  - id: op_not
    type:
      - 'null'
      - boolean
    doc: 'Calculate !vol1.'
    inputBinding:
      position: 1
      prefix: '-not'
  - id: isnan
    type:
      - 'null'
      - boolean
    doc: 'Test for NaN values in vol1.'
    inputBinding:
      position: 1
      prefix: '-isnan'
  - id: nisnan
    type:
      - 'null'
      - boolean
    doc: 'Negation of -isnan.'
    inputBinding:
      position: 1
      prefix: '-nisnan'
  - id: count_valid
    type:
      - 'null'
      - boolean
    doc: 'Count the number of valid values in N volumes.'
    inputBinding:
      position: 1
      prefix: '-count_valid'
outputs:
  - id: output_file
    type: File
    doc: Output MINC file.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/minc-tools:v2.3.00dfsg-1.1b1-deb_cv1
