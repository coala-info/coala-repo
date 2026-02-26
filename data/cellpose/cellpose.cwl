cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellpose
label: cellpose
doc: "Cellpose Command Line Parameters\n\nTool homepage: https://github.com/MouseLand/cellpose"
inputs:
  - id: add_model
    type:
      - 'null'
      - string
    doc: model path to copy model to hidden .cellpose folder for using in 
      GUI/CLI
    inputBinding:
      position: 101
      prefix: --add_model
  - id: all_channels
    type:
      - 'null'
      - boolean
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --all_channels
  - id: anisotropy
    type:
      - 'null'
      - float
    doc: anisotropy of volume in 3D
    inputBinding:
      position: 101
      prefix: --anisotropy
  - id: augment
    type:
      - 'null'
      - boolean
    doc: tiles image with overlapping tiles and flips overlapped regions to 
      augment
    inputBinding:
      position: 101
      prefix: --augment
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'inference batch size. Default: 8'
    default: 8
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: bsize
    type:
      - 'null'
      - int
    doc: 'block size for tiles. Default: 256'
    default: 256
    inputBinding:
      position: 101
      prefix: --bsize
  - id: cellprob_threshold
    type:
      - 'null'
      - float
    doc: cellprob threshold, default is 0, decrease to find more and larger 
      masks
    default: 0
    inputBinding:
      position: 101
      prefix: --cellprob_threshold
  - id: chan
    type:
      - 'null'
      - string
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --chan
  - id: chan2
    type:
      - 'null'
      - string
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --chan2
  - id: chan2_restore
    type:
      - 'null'
      - boolean
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --chan2_restore
  - id: channel_axis
    type:
      - 'null'
      - int
    doc: axis of image which corresponds to image channels
    inputBinding:
      position: 101
      prefix: --channel_axis
  - id: diam_mean
    type:
      - 'null'
      - float
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --diam_mean
  - id: diameter
    type:
      - 'null'
      - float
    doc: use to resize cells to the training diameter (30 pixels)
    inputBinding:
      position: 101
      prefix: --diameter
  - id: dir
    type:
      - 'null'
      - Directory
    doc: folder containing data to run or train on.
    inputBinding:
      position: 101
      prefix: --dir
  - id: dir_above
    type:
      - 'null'
      - boolean
    doc: save output folders adjacent to image folder instead of inside it (off 
      by default)
    inputBinding:
      position: 101
      prefix: --dir_above
  - id: do_3d
    type:
      - 'null'
      - boolean
    doc: process images as 3D stacks of images (nplanes x nchan x Ly x Lx
    inputBinding:
      position: 101
      prefix: --do_3D
  - id: exclude_on_edges
    type:
      - 'null'
      - boolean
    doc: discard masks which touch edges of image
    inputBinding:
      position: 101
      prefix: --exclude_on_edges
  - id: file_list
    type:
      - 'null'
      - File
    doc: path to list of files for training and testing and probabilities for 
      each image (optional)
    inputBinding:
      position: 101
      prefix: --file_list
  - id: flow3d_smooth
    type:
      - 'null'
      - float
    doc: stddev of gaussian for smoothing of dP for dynamics in 3D, default of 0
      means no smoothing
    default: 0
    inputBinding:
      position: 101
      prefix: --flow3D_smooth
  - id: flow_threshold
    type:
      - 'null'
      - float
    doc: 'flow error threshold, 0 turns off this optional QC step. Default: 0.4'
    default: 0.4
    inputBinding:
      position: 101
      prefix: --flow_threshold
  - id: gpu_device
    type:
      - 'null'
      - string
    doc: which gpu device to use, use an integer for torch, or mps for M1
    inputBinding:
      position: 101
      prefix: --gpu_device
  - id: image_path
    type:
      - 'null'
      - File
    doc: if given and --dir not given, run on single image instead of folder 
      (cannot train with this option)
    inputBinding:
      position: 101
      prefix: --image_path
  - id: img_filter
    type:
      - 'null'
      - string
    doc: end string for images to run on
    inputBinding:
      position: 101
      prefix: --img_filter
  - id: in_folders
    type:
      - 'null'
      - boolean
    doc: flag to save output in folders (off by default)
    inputBinding:
      position: 101
      prefix: --in_folders
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --invert
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: 'learning rate. Default: 1e-05'
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --learning_rate
  - id: look_one_level_down
    type:
      - 'null'
      - boolean
    doc: run processing on all subdirectories of current folder
    inputBinding:
      position: 101
      prefix: --look_one_level_down
  - id: mask_filter
    type:
      - 'null'
      - string
    doc: "end string for masks to run on. use '_seg.npy' for manual annotations from
      the GUI. Default: _masks"
    default: _masks
    inputBinding:
      position: 101
      prefix: --mask_filter
  - id: min_size
    type:
      - 'null'
      - int
    doc: minimum number of pixels per mask, can turn off with -1
    default: -1
    inputBinding:
      position: 101
      prefix: --min_size
  - id: min_train_masks
    type:
      - 'null'
      - int
    doc: 'minimum number of masks a training image must have to be used. Default:
      5'
    default: 5
    inputBinding:
      position: 101
      prefix: --min_train_masks
  - id: model_name_out
    type:
      - 'null'
      - string
    doc: Name of model to save as, defaults to name describing model 
      architecture. Model is saved in the folder specified by --dir in models 
      subfolder.
    inputBinding:
      position: 101
      prefix: --model_name_out
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: 'number of epochs. Default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --n_epochs
  - id: nimg_per_epoch
    type:
      - 'null'
      - int
    doc: number of train images per epoch. Default is to use all train images.
    inputBinding:
      position: 101
      prefix: --nimg_per_epoch
  - id: nimg_test_per_epoch
    type:
      - 'null'
      - int
    doc: number of test images per epoch. Default is to use all test images.
    inputBinding:
      position: 101
      prefix: --nimg_test_per_epoch
  - id: niter
    type:
      - 'null'
      - int
    doc: niter, number of iterations for dynamics for mask creation, default of 
      0 means it is proportional to diameter, set to a larger number like 2000 
      for very long ROIs
    default: 0
    inputBinding:
      position: 101
      prefix: --niter
  - id: no_interp
    type:
      - 'null'
      - boolean
    doc: do not interpolate when running dynamics (was default)
    inputBinding:
      position: 101
      prefix: --no_interp
  - id: no_norm
    type:
      - 'null'
      - boolean
    doc: do not normalize images (normalize=False)
    inputBinding:
      position: 101
      prefix: --no_norm
  - id: no_npy
    type:
      - 'null'
      - boolean
    doc: suppress saving of npy
    inputBinding:
      position: 101
      prefix: --no_npy
  - id: no_resample
    type:
      - 'null'
      - boolean
    doc: disables flows/cellprob resampling to original image size before 
      computing masks. Using this flag will make more masks more jagged with 
      larger diameter settings.
    inputBinding:
      position: 101
      prefix: --no_resample
  - id: norm_percentile
    type:
      - 'null'
      - type: array
        items: float
    doc: Provide two float values to set norm_percentile (e.g., 
      --norm_percentile 1 99)
    inputBinding:
      position: 101
      prefix: --norm_percentile
  - id: output_name
    type:
      - 'null'
      - string
    doc: suffix for saved masks, default is _cp_masks, can be empty if `savedir`
      used and different of `dir`
    inputBinding:
      position: 101
      prefix: --output_name
  - id: pretrained_model
    type:
      - 'null'
      - string
    doc: model to use for running or starting training
    inputBinding:
      position: 101
      prefix: --pretrained_model
  - id: pretrained_model_ortho
    type:
      - 'null'
      - string
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --pretrained_model_ortho
  - id: restore_type
    type:
      - 'null'
      - string
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --restore_type
  - id: save_each
    type:
      - 'null'
      - boolean
    doc: 'wether or not to save each epoch. Must also use --save_every. (default:
      False)'
    default: false
    inputBinding:
      position: 101
      prefix: --save_each
  - id: save_every
    type:
      - 'null'
      - int
    doc: 'number of epochs to skip between saves. Default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --save_every
  - id: save_flows
    type:
      - 'null'
      - boolean
    doc: whether or not to save RGB images of flows when masks are saved 
      (disabled by default)
    inputBinding:
      position: 101
      prefix: --save_flows
  - id: save_mpl
    type:
      - 'null'
      - boolean
    doc: save a figure of image/mask/flows using matplotlib (disabled by 
      default). This is slow, especially with large images.
    inputBinding:
      position: 101
      prefix: --save_mpl
  - id: save_outlines
    type:
      - 'null'
      - boolean
    doc: whether or not to save RGB outline images when masks are saved 
      (disabled by default)
    inputBinding:
      position: 101
      prefix: --save_outlines
  - id: save_png
    type:
      - 'null'
      - boolean
    doc: save masks as png
    inputBinding:
      position: 101
      prefix: --save_png
  - id: save_rois
    type:
      - 'null'
      - boolean
    doc: whether or not to save ImageJ compatible ROI archive (disabled by 
      default)
    inputBinding:
      position: 101
      prefix: --save_rois
  - id: save_tif
    type:
      - 'null'
      - boolean
    doc: save masks as tif
    inputBinding:
      position: 101
      prefix: --save_tif
  - id: save_txt
    type:
      - 'null'
      - boolean
    doc: flag to enable txt outlines for ImageJ (disabled by default)
    inputBinding:
      position: 101
      prefix: --save_txt
  - id: savedir
    type:
      - 'null'
      - Directory
    doc: folder to which segmentation results will be saved (defaults to input 
      image directory)
    inputBinding:
      position: 101
      prefix: --savedir
  - id: sgd
    type:
      - 'null'
      - string
    doc: Deprecated in v4.0.1+, not used - AdamW used instead.
    inputBinding:
      position: 101
      prefix: --SGD
  - id: stitch_threshold
    type:
      - 'null'
      - float
    doc: compute masks in 2D then stitch together masks with IoU>0.9 across 
      planes
    inputBinding:
      position: 101
      prefix: --stitch_threshold
  - id: test_dir
    type:
      - 'null'
      - Directory
    doc: folder containing test data (optional)
    inputBinding:
      position: 101
      prefix: --test_dir
  - id: train
    type:
      - 'null'
      - boolean
    doc: train network using images in dir
    inputBinding:
      position: 101
      prefix: --train
  - id: train_batch_size
    type:
      - 'null'
      - int
    doc: 'training batch size. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --train_batch_size
  - id: train_size
    type:
      - 'null'
      - boolean
    doc: Deprecated in v4.0.1+, not used.
    inputBinding:
      position: 101
      prefix: --train_size
  - id: transformer
    type:
      - 'null'
      - boolean
    doc: use transformer backbone (pretrained_model from Cellpose3 is 
      transformer_cp3)
    inputBinding:
      position: 101
      prefix: --transformer
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: use gpu if torch with cuda installed
    inputBinding:
      position: 101
      prefix: --use_gpu
  - id: weight_decay
    type:
      - 'null'
      - float
    doc: 'weight decay. Default: 0.1'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --weight_decay
  - id: z_axis
    type:
      - 'null'
      - int
    doc: axis of image which corresponds to Z dimension
    inputBinding:
      position: 101
      prefix: --z_axis
  - id: zstack
    type:
      - 'null'
      - boolean
    doc: run GUI in 3D mode
    inputBinding:
      position: 101
      prefix: --Zstack
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellpose:4.0.8
stdout: cellpose.out
