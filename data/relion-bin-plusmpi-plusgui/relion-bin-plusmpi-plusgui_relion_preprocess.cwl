cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_preprocess
label: relion-bin-plusmpi-plusgui_relion_preprocess
doc: "RELION particle preprocessing: extract, normalise, rescale and window particles\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: output_rootname
    type: string
    doc: "Output rootname"
    inputBinding:
      position: 101
      prefix: --o
  - id: coord_files
    type:
      - 'null'
      - string
    doc: "The coordinate files for all particles to be output (may contain wildcards e.g. 'mics/*.box' or 'mics/???.star' )"
    inputBinding:
      position: 101
      prefix: --coord_files
  - id: mic_star
    type:
      - 'null'
      - File
    doc: "The STAR file with all (selected) micrographs to extract particles from"
    inputBinding:
      position: 101
      prefix: --mic_star
  - id: coord_suffix
    type:
      - 'null'
      - string
    doc: "The suffix for the coordinate files, e.g. '_picked.star' or '.box'"
    inputBinding:
      position: 101
      prefix: --coord_suffix
  - id: extract
    type:
      - 'null'
      - boolean
    doc: "Extract all particles from the micrographs"
    inputBinding:
      position: 101
      prefix: --extract
  - id: extract_size
    type:
      - 'null'
      - int
    doc: "Size of the box to extract the particles in (in pixels)"
    inputBinding:
      position: 101
      prefix: --extract_size
  - id: extract_bias_x
    type:
      - 'null'
      - int
    doc: "Bias in X-direction of picked particles (this value in pixels will be added to the coords)"
    inputBinding:
      position: 101
      prefix: --extract_bias_x
  - id: extract_bias_y
    type:
      - 'null'
      - int
    doc: "Bias in Y-direction of picked particles (this value in pixels will be added to the coords)"
    inputBinding:
      position: 101
      prefix: --extract_bias_y
  - id: extract_movies
    type:
      - 'null'
      - boolean
    doc: "Extract particles from movie stacks (e.g. from DDDs)"
    inputBinding:
      position: 101
      prefix: --extract_movies
  - id: avg_movie_frames
    type:
      - 'null'
      - int
    doc: "Average over this number of individual movie frames"
    inputBinding:
      position: 101
      prefix: --avg_movie_frames
  - id: first_movie_frame
    type:
      - 'null'
      - int
    doc: "Extract from this movie frame onwards"
    inputBinding:
      position: 101
      prefix: --first_movie_frame
  - id: last_movie_frame
    type:
      - 'null'
      - int
    doc: "Extract until this movie frame (default=all movie frames)"
    inputBinding:
      position: 101
      prefix: --last_movie_frame
  - id: movie_rootname
    type:
      - 'null'
      - string
    doc: "Common name to relate movies to the single micrographs (e.g. mic001_movie.mrcs related to mic001.mrc)"
    inputBinding:
      position: 101
      prefix: --movie_rootname
  - id: project3d
    type:
      - 'null'
      - boolean
    doc: "Project sub-tomograms along Z to generate 2D particles"
    inputBinding:
      position: 101
      prefix: --project3d
  - id: scale
    type:
      - 'null'
      - int
    doc: "Re-scale the particles to this size (in pixels)"
    inputBinding:
      position: 101
      prefix: --scale
  - id: window
    type:
      - 'null'
      - int
    doc: "Re-window the particles to this size (in pixels)"
    inputBinding:
      position: 101
      prefix: --window
  - id: norm
    type:
      - 'null'
      - boolean
    doc: "Normalise the background to average zero and stddev one"
    inputBinding:
      position: 101
      prefix: --norm
  - id: no_ramp
    type:
      - 'null'
      - boolean
    doc: "Just subtract the background mean in the normalisation, instead of subtracting a fitted ramping background."
    inputBinding:
      position: 101
      prefix: --no_ramp
  - id: bg_radius
    type:
      - 'null'
      - int
    doc: "Radius of the circular mask that will be used to define the background area (in pixels)"
    inputBinding:
      position: 101
      prefix: --bg_radius
  - id: white_dust
    type:
      - 'null'
      - float
    doc: "Sigma-values above which white dust will be removed (negative value means no dust removal)"
    inputBinding:
      position: 101
      prefix: --white_dust
  - id: black_dust
    type:
      - 'null'
      - float
    doc: "Sigma-values above which black dust will be removed (negative value means no dust removal)"
    inputBinding:
      position: 101
      prefix: --black_dust
  - id: invert_contrast
    type:
      - 'null'
      - boolean
    doc: "Invert the contrast in the input images"
    inputBinding:
      position: 101
      prefix: --invert_contrast
  - id: operate_on
    type:
      - 'null'
      - File
    doc: "The operations above are applied to all extracted particles. Use this option to operate on an input stack/STAR file"
    inputBinding:
      position: 101
      prefix: --operate_on
  - id: particle_stacks
    type:
      - 'null'
      - type: array
        items: File
    doc: "Image stacks (.mrcs) named in the input STAR file, staged in the working directory so the names resolve"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: out_files
    type:
      type: array
      items: File
    doc: "Files written with the output rootname"
    outputBinding:
      glob: $(inputs.output_rootname)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.particle_stacks) { l = l.concat(inputs.particle_stacks); }
        var r = inputs.output_rootname;
        if (r && r.indexOf("/") >= 0) {
          var dn = r.substring(0, r.lastIndexOf("/"));
          l.push({"entryname": dn, "entry": {"class": "Directory", "basename": dn, "listing": []}, "writable": true});
        }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_preprocess.out
