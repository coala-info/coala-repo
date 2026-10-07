# dcm2niix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dcm2niix | PASS |  |

## dcm2niix

### Tool Description
Convert DICOM images to NIfTI format

### Metadata
- **Docker Image**: biocontainers/dcm2niix:v1.0.20181125-1-deb_cv1
- **Homepage**: https://github.com/rordenlab/dcm2niix
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/dcm2niix/overview
- **Total Downloads**: 372.8K
- **Last updated**: 2026-09-23
- **GitHub**: https://github.com/rordenlab/dcm2niix
- **Stars**: N/A
### Original Help Text
```text
Compression will be faster with 'pigz' installed
Chris Rorden's dcm2niiX version v1.0.20181125  (JP2:OpenJPEG) GCC8.2.0 (64-bit Linux)
usage: dcm2niix [options] <in_folder>
 Options :
  -1..-9 : gz compression level (1=fastest..9=smallest, default 6)
  -b : BIDS sidecar (y/n/o [o=only: no NIfTI], default y)
   -ba : anonymize BIDS (y/n, default y)
  -c : comment stored in NIfTI aux_file (up to 24 characters)
  -d : directory search depth. Convert DICOMs in sub-folders of in_folder? (0..9, default 5)
  -f : filename (%a=antenna (coil) name, %b=basename, %c=comments, %d=description, %e=echo number, %f=folder name, %i=ID of patient, %j=seriesInstanceUID, %k=studyInstanceUID, %m=manufacturer, %n=name of patient, %p=protocol, %r=instance number, %s=series number, %t=time, %u=acquisition number, %v=vendor, %x=study ID; %z=sequence name; default '%f_%p_%t_%s')
  -g : generate defaults file (y/n/o/i [o=only: reset and write defaults; i=ignore: reset defaults], default n)
  -h : show help
  -i : ignore derived, localizer and 2D images (y/n, default n)
  -l : losslessly scale 16-bit integers to use dynamic range (y/n, default n)
  -m : merge 2D slices from same series regardless of study time, echo, coil, orientation, etc. (y/n, default n)
  -n : only convert this series number - can be used up to 16 times (default convert all)
  -o : output directory (omit to save to input folder)
  -p : Philips precise float (not display) scaling (y/n, default y)
  -r : rename instead of convert DICOMs (y/n, default n)
  -s : single file mode, do not convert other images in folder (y/n, default n)
  -t : text notes includes private patient details (y/n, default n)
  -u : up-to-date check
  -v : verbose (n/y or 0/1/2 [no, yes, logorrheic], default 0)
  -x : crop (y/n, default n)
  -z : gz compress images (y/i/n/3, default n) [y=pigz, i=internal:miniz, n=no, 3=no,3D]
 Defaults file : /home/user/.dcm2nii.ini
 Examples :
  dcm2niix /Users/chris/dir
  dcm2niix -c "my comment" /Users/chris/dir
  dcm2niix -o /users/cr/outdir/ -z y ~/dicomdir
  dcm2niix -f %p_%s -b y -ba n ~/dicomdir
  dcm2niix -f mystudy%s ~/dicomdir
  dcm2niix -o "~/dir with spaces/dir" ~/dicomdir
Example output filename: '/myFolder_MPRAGE_19770703150928_1.nii'
```
