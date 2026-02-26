cwlVersion: v1.2
class: CommandLineTool
baseCommand: bftools_formatlist
label: bftools_formatlist
doc: "List supported image formats\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: adobe_photoshop
    type:
      - 'null'
      - string
    doc: can read (psd)
    inputBinding:
      position: 101
      prefix: Adobe Photoshop
  - id: adobe_photoshop_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Adobe Photoshop TIFF
  - id: aim
    type:
      - 'null'
      - string
    doc: can read (aim)
    inputBinding:
      position: 101
      prefix: AIM
  - id: alicona_al3d
    type:
      - 'null'
      - string
    doc: can read (al3d)
    inputBinding:
      position: 101
      prefix: Alicona AL3D
  - id: amersham_biosciences_gel
    type:
      - 'null'
      - string
    doc: can read (gel)
    inputBinding:
      position: 101
      prefix: Amersham Biosciences GEL
  - id: amira
    type:
      - 'null'
      - string
    doc: can read (am, amiramesh, grey, hx, labels)
    inputBinding:
      position: 101
      prefix: Amira
  - id: analyze_7_5
    type:
      - 'null'
      - string
    doc: can read (img, hdr)
    inputBinding:
      position: 101
      prefix: Analyze 7.5
  - id: andor_sif
    type:
      - 'null'
      - string
    doc: can read (sif)
    inputBinding:
      position: 101
      prefix: Andor SIF
  - id: animated_png
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (png)
    inputBinding:
      position: 101
      prefix: Animated PNG
  - id: aperio_afi
    type:
      - 'null'
      - string
    doc: can read (afi)
    inputBinding:
      position: 101
      prefix: Aperio AFI
  - id: aperio_svs
    type:
      - 'null'
      - string
    doc: can read (svs)
    inputBinding:
      position: 101
      prefix: Aperio SVS
  - id: arf
    type:
      - 'null'
      - string
    doc: can read (arf)
    inputBinding:
      position: 101
      prefix: ARF
  - id: audio_video_interleave
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (avi)
    inputBinding:
      position: 101
      prefix: Audio Video Interleave
  - id: bd_pathway
    type:
      - 'null'
      - string
    doc: can read (exp, tif)
    inputBinding:
      position: 101
      prefix: BD Pathway
  - id: bdv
    type:
      - 'null'
      - string
    doc: can read (xml, h5)
    inputBinding:
      position: 101
      prefix: BDV
  - id: bio_rad_gel
    type:
      - 'null'
      - string
    doc: can read (1sc)
    inputBinding:
      position: 101
      prefix: Bio-Rad GEL
  - id: bio_rad_pic
    type:
      - 'null'
      - string
    doc: can read (pic, xml, raw)
    inputBinding:
      position: 101
      prefix: Bio-Rad PIC
  - id: bio_rad_scn
    type:
      - 'null'
      - string
    doc: can read (scn)
    inputBinding:
      position: 101
      prefix: Bio-Rad SCN
  - id: bitplane_imaris
    type:
      - 'null'
      - string
    doc: can read (ims)
    inputBinding:
      position: 101
      prefix: Bitplane Imaris
  - id: bitplane_imaris_3_tiff
    type:
      - 'null'
      - string
    doc: can read (ims)
    inputBinding:
      position: 101
      prefix: Bitplane Imaris 3 (TIFF)
  - id: bitplane_imaris_5_5_hdf
    type:
      - 'null'
      - string
    doc: can read (ims)
    inputBinding:
      position: 101
      prefix: Bitplane Imaris 5.5 (HDF)
  - id: bruker
    type:
      - 'null'
      - string
    doc: can read ()
    inputBinding:
      position: 101
      prefix: Bruker
  - id: burleigh
    type:
      - 'null'
      - string
    doc: can read (img)
    inputBinding:
      position: 101
      prefix: Burleigh
  - id: canon_raw
    type:
      - 'null'
      - string
    doc: can read (cr2, crw, jpg, thm, wav)
    inputBinding:
      position: 101
      prefix: Canon RAW
  - id: cellh5_hdf
    type:
      - 'null'
      - string
    doc: can read (ch5)
    inputBinding:
      position: 101
      prefix: CellH5 (HDF)
  - id: cellomics_c01
    type:
      - 'null'
      - string
    doc: can read (c01, dib)
    inputBinding:
      position: 101
      prefix: Cellomics C01
  - id: cellsens_vsi
    type:
      - 'null'
      - string
    doc: can read (vsi, ets)
    inputBinding:
      position: 101
      prefix: CellSens VSI
  - id: cellvoyager
    type:
      - 'null'
      - string
    doc: can read (tif, xml)
    inputBinding:
      position: 101
      prefix: CellVoyager
  - id: cellworx
    type:
      - 'null'
      - string
    doc: can read (pnl, htd, log)
    inputBinding:
      position: 101
      prefix: CellWorx
  - id: compix_simple_pci
    type:
      - 'null'
      - string
    doc: can read (cxd)
    inputBinding:
      position: 101
      prefix: Compix Simple-PCI
  - id: deltavision
    type:
      - 'null'
      - string
    doc: can read (dv, r3d, r3d_d3d, dv.log, r3d.log)
    inputBinding:
      position: 101
      prefix: Deltavision
  - id: dicom
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (dic, dcm, dicom, jp2, j2ki, 
      j2kr, raw, ima)
    inputBinding:
      position: 101
      prefix: DICOM
  - id: dng
    type:
      - 'null'
      - string
    doc: can read (cr2, crw, jpg, thm, wav, tif, tiff)
    inputBinding:
      position: 101
      prefix: DNG
  - id: ecat7
    type:
      - 'null'
      - string
    doc: can read (v)
    inputBinding:
      position: 101
      prefix: ECAT7
  - id: encapsulated_postscript
    type:
      - 'null'
      - string
    doc: can read, can write (eps, epsi, ps)
    inputBinding:
      position: 101
      prefix: Encapsulated PostScript
  - id: evotec_flex
    type:
      - 'null'
      - string
    doc: can read (flex, mea, res)
    inputBinding:
      position: 101
      prefix: Evotec Flex
  - id: extended_leica_file
    type:
      - 'null'
      - string
    doc: can read (xlef)
    inputBinding:
      position: 101
      prefix: Extended leica file
  - id: fei_philips
    type:
      - 'null'
      - string
    doc: can read (img)
    inputBinding:
      position: 101
      prefix: FEI/Philips
  - id: fei_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: FEI TIFF
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: can read (pattern)
    inputBinding:
      position: 101
      prefix: File pattern
  - id: flexible_image_transport_system
    type:
      - 'null'
      - string
    doc: can read (fits, fts)
    inputBinding:
      position: 101
      prefix: Flexible Image Transport System
  - id: flowsight
    type:
      - 'null'
      - string
    doc: can read (cif)
    inputBinding:
      position: 101
      prefix: FlowSight
  - id: fuji_las_3000
    type:
      - 'null'
      - string
    doc: can read (img, inf)
    inputBinding:
      position: 101
      prefix: Fuji LAS 3000
  - id: gatan_digital_micrograph
    type:
      - 'null'
      - string
    doc: can read (dm3, dm4)
    inputBinding:
      position: 101
      prefix: Gatan Digital Micrograph
  - id: gatan_dm2
    type:
      - 'null'
      - string
    doc: can read (dm2)
    inputBinding:
      position: 101
      prefix: Gatan DM2
  - id: graphics_interchange_format
    type:
      - 'null'
      - string
    doc: can read (gif)
    inputBinding:
      position: 101
      prefix: Graphics Interchange Format
  - id: hamamatsu_aquacosmos
    type:
      - 'null'
      - string
    doc: can read (naf)
    inputBinding:
      position: 101
      prefix: Hamamatsu Aquacosmos
  - id: hamamatsu_his
    type:
      - 'null'
      - string
    doc: can read (his)
    inputBinding:
      position: 101
      prefix: Hamamatsu HIS
  - id: hamamatsu_ndpi
    type:
      - 'null'
      - string
    doc: can read (ndpi)
    inputBinding:
      position: 101
      prefix: Hamamatsu NDPI
  - id: hamamatsu_ndpis
    type:
      - 'null'
      - string
    doc: can read (ndpis)
    inputBinding:
      position: 101
      prefix: Hamamatsu NDPIS
  - id: hamamatsu_vms
    type:
      - 'null'
      - string
    doc: can read (vms)
    inputBinding:
      position: 101
      prefix: Hamamatsu VMS
  - id: hitachi
    type:
      - 'null'
      - string
    doc: can read (txt)
    inputBinding:
      position: 101
      prefix: Hitachi
  - id: i2i
    type:
      - 'null'
      - string
    doc: can read (i2i)
    inputBinding:
      position: 101
      prefix: I2I
  - id: imacon
    type:
      - 'null'
      - string
    doc: can read (fff)
    inputBinding:
      position: 101
      prefix: Imacon
  - id: image_cytometry_standard
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (ics, ids)
    inputBinding:
      position: 101
      prefix: Image Cytometry Standard
  - id: image_pro_sequence
    type:
      - 'null'
      - string
    doc: can read (seq, ips)
    inputBinding:
      position: 101
      prefix: Image-Pro Sequence
  - id: image_pro_workspace
    type:
      - 'null'
      - string
    doc: can read (ipw)
    inputBinding:
      position: 101
      prefix: Image-Pro Workspace
  - id: imagic
    type:
      - 'null'
      - string
    doc: can read (hed, img)
    inputBinding:
      position: 101
      prefix: IMAGIC
  - id: imod
    type:
      - 'null'
      - string
    doc: can read (mod)
    inputBinding:
      position: 101
      prefix: IMOD
  - id: improvision_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Improvision TIFF
  - id: incell_1000_2000
    type:
      - 'null'
      - string
    doc: can read (xdce, xml, tiff, tif, xlog)
    inputBinding:
      position: 101
      prefix: InCell 1000/2000
  - id: incell_3000
    type:
      - 'null'
      - string
    doc: can read (frm)
    inputBinding:
      position: 101
      prefix: InCell 3000
  - id: inr
    type:
      - 'null'
      - string
    doc: can read (inr)
    inputBinding:
      position: 101
      prefix: INR
  - id: inveon
    type:
      - 'null'
      - string
    doc: can read (hdr)
    inputBinding:
      position: 101
      prefix: Inveon
  - id: ionpath_mibi
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Ionpath MIBI
  - id: iplab
    type:
      - 'null'
      - string
    doc: can read (ipl)
    inputBinding:
      position: 101
      prefix: IPLab
  - id: ivision
    type:
      - 'null'
      - string
    doc: can read (ipm)
    inputBinding:
      position: 101
      prefix: IVision
  - id: jeol
    type:
      - 'null'
      - string
    doc: can read (dat, img, par)
    inputBinding:
      position: 101
      prefix: JEOL
  - id: jpeg
    type:
      - 'null'
      - string
    doc: can read, can write (jpg, jpeg, jpe)
    inputBinding:
      position: 101
      prefix: JPEG
  - id: jpeg_2000
    type:
      - 'null'
      - string
    doc: can read, can write (jp2, j2k, jpf)
    inputBinding:
      position: 101
      prefix: JPEG-2000
  - id: jpk_instruments
    type:
      - 'null'
      - string
    doc: can read (jpk)
    inputBinding:
      position: 101
      prefix: JPK Instruments
  - id: jpx
    type:
      - 'null'
      - string
    doc: can read (jpx)
    inputBinding:
      position: 101
      prefix: JPX
  - id: khoros_xv
    type:
      - 'null'
      - string
    doc: can read (xv)
    inputBinding:
      position: 101
      prefix: Khoros XV
  - id: klb
    type:
      - 'null'
      - string
    doc: can read (klb)
    inputBinding:
      position: 101
      prefix: KLB
  - id: kodak_molecular_imaging
    type:
      - 'null'
      - string
    doc: can read (bip)
    inputBinding:
      position: 101
      prefix: Kodak Molecular Imaging
  - id: laboratory_imaging
    type:
      - 'null'
      - string
    doc: can read (lim)
    inputBinding:
      position: 101
      prefix: Laboratory Imaging
  - id: lavision_imspector
    type:
      - 'null'
      - string
    doc: can read (msr)
    inputBinding:
      position: 101
      prefix: Lavision Imspector
  - id: leica
    type:
      - 'null'
      - string
    doc: can read (lei, tif, tiff, raw)
    inputBinding:
      position: 101
      prefix: Leica
  - id: leica_image_file_format
    type:
      - 'null'
      - string
    doc: can read (lif)
    inputBinding:
      position: 101
      prefix: Leica Image File Format
  - id: leica_object_format
    type:
      - 'null'
      - string
    doc: can read (lof)
    inputBinding:
      position: 101
      prefix: Leica Object Format
  - id: leica_scn
    type:
      - 'null'
      - string
    doc: can read (scn)
    inputBinding:
      position: 101
      prefix: Leica SCN
  - id: leica_tcs_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff, xml)
    inputBinding:
      position: 101
      prefix: Leica TCS TIFF
  - id: leo
    type:
      - 'null'
      - string
    doc: can read (sxm, tif, tiff)
    inputBinding:
      position: 101
      prefix: LEO
  - id: li_cor_l2d
    type:
      - 'null'
      - string
    doc: can read (l2d, scn, tif)
    inputBinding:
      position: 101
      prefix: Li-Cor L2D
  - id: li_flim
    type:
      - 'null'
      - string
    doc: can read (fli)
    inputBinding:
      position: 101
      prefix: LI-FLIM
  - id: medical_research_council
    type:
      - 'null'
      - string
    doc: can read (mrc, st, ali, map, rec, mrcs)
    inputBinding:
      position: 101
      prefix: Medical Research Council
  - id: metamorph_stk
    type:
      - 'null'
      - string
    doc: can read (stk, nd, scan, tif, tiff)
    inputBinding:
      position: 101
      prefix: Metamorph STK
  - id: metamorph_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Metamorph TIFF
  - id: metaxpress_tiff
    type:
      - 'null'
      - string
    doc: can read (htd, tif)
    inputBinding:
      position: 101
      prefix: MetaXpress TIFF
  - id: mias
    type:
      - 'null'
      - string
    doc: can read (tif, tiff, txt)
    inputBinding:
      position: 101
      prefix: MIAS
  - id: micro_manager
    type:
      - 'null'
      - string
    doc: can read (tif, tiff, txt, xml)
    inputBinding:
      position: 101
      prefix: Micro-Manager
  - id: microct
    type:
      - 'null'
      - string
    doc: can read (vff)
    inputBinding:
      position: 101
      prefix: MicroCT
  - id: mikroscan_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Mikroscan TIFF
  - id: minc_mri
    type:
      - 'null'
      - string
    doc: can read (mnc)
    inputBinding:
      position: 101
      prefix: MINC MRI
  - id: minolta_mrw
    type:
      - 'null'
      - string
    doc: can read (mrw)
    inputBinding:
      position: 101
      prefix: Minolta MRW
  - id: molecular_imaging
    type:
      - 'null'
      - string
    doc: can read (stp)
    inputBinding:
      position: 101
      prefix: Molecular Imaging
  - id: multiple_image_network_graphics
    type:
      - 'null'
      - string
    doc: can read (mng)
    inputBinding:
      position: 101
      prefix: Multiple-image Network Graphics
  - id: nifti
    type:
      - 'null'
      - string
    doc: can read (nii, img, hdr, nii.gz)
    inputBinding:
      position: 101
      prefix: NIfTI
  - id: nikon_elements_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Nikon Elements TIFF
  - id: nikon_nd2
    type:
      - 'null'
      - string
    doc: can read (nd2, jp2)
    inputBinding:
      position: 101
      prefix: Nikon ND2
  - id: nikon_nef
    type:
      - 'null'
      - string
    doc: can read (nef, tif, tiff)
    inputBinding:
      position: 101
      prefix: Nikon NEF
  - id: nikon_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Nikon TIFF
  - id: noaa_hrd_gridded_data_format
    type:
      - 'null'
      - string
    doc: can read ()
    inputBinding:
      position: 101
      prefix: NOAA-HRD Gridded Data Format
  - id: nrrd
    type:
      - 'null'
      - string
    doc: can read (nrrd, nhdr)
    inputBinding:
      position: 101
      prefix: NRRD
  - id: obf
    type:
      - 'null'
      - string
    doc: can read (obf, msr)
    inputBinding:
      position: 101
      prefix: OBF
  - id: olympus_apl
    type:
      - 'null'
      - string
    doc: can read (apl, tnb, mtb, tif)
    inputBinding:
      position: 101
      prefix: Olympus APL
  - id: olympus_fluoview_abd_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Olympus Fluoview/ABD TIFF
  - id: olympus_fv1000
    type:
      - 'null'
      - string
    doc: can read (oib, oif, pty, lut)
    inputBinding:
      position: 101
      prefix: Olympus FV1000
  - id: olympus_oir
    type:
      - 'null'
      - string
    doc: can read (oir)
    inputBinding:
      position: 101
      prefix: Olympus OIR
  - id: olympus_omp2info
    type:
      - 'null'
      - string
    doc: can read (omp2info)
    inputBinding:
      position: 101
      prefix: Olympus .omp2info
  - id: olympus_scanr
    type:
      - 'null'
      - string
    doc: can read (dat, xml, tif)
    inputBinding:
      position: 101
      prefix: Olympus ScanR
  - id: olympus_sis_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Olympus SIS TIFF
  - id: olympus_slidebook
    type:
      - 'null'
      - string
    doc: can read (sld, spl)
    inputBinding:
      position: 101
      prefix: Olympus Slidebook
  - id: ome_tiff
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (ome.tiff, ome.tif, ome.tf2, 
      ome.tf8, ome.btf, companion.ome)
    inputBinding:
      position: 101
      prefix: OME-TIFF
  - id: ome_xml
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (ome, ome.xml)
    inputBinding:
      position: 101
      prefix: OME-XML
  - id: openlab_liff
    type:
      - 'null'
      - string
    doc: can read (liff)
    inputBinding:
      position: 101
      prefix: Openlab LIFF
  - id: openlab_raw
    type:
      - 'null'
      - string
    doc: can read (raw)
    inputBinding:
      position: 101
      prefix: Openlab RAW
  - id: oxford_instruments
    type:
      - 'null'
      - string
    doc: can read (top)
    inputBinding:
      position: 101
      prefix: Oxford Instruments
  - id: pco_raw
    type:
      - 'null'
      - string
    doc: can read (pcoraw, rec)
    inputBinding:
      position: 101
      prefix: PCO-RAW
  - id: pcx
    type:
      - 'null'
      - string
    doc: can read (pcx)
    inputBinding:
      position: 101
      prefix: PCX
  - id: perkin_elmer_densitometer
    type:
      - 'null'
      - string
    doc: can read (hdr, img)
    inputBinding:
      position: 101
      prefix: Perkin Elmer Densitometer
  - id: perkin_elmer_nuance_im3
    type:
      - 'null'
      - string
    doc: can read (im3)
    inputBinding:
      position: 101
      prefix: Perkin-Elmer Nuance IM3
  - id: perkinelmer
    type:
      - 'null'
      - string
    doc: can read (ano, cfg, csv, htm, rec, tim, zpo, tif)
    inputBinding:
      position: 101
      prefix: PerkinElmer
  - id: perkinelmer_columbus
    type:
      - 'null'
      - string
    doc: can read (xml)
    inputBinding:
      position: 101
      prefix: PerkinElmer Columbus
  - id: perkinelmer_operetta
    type:
      - 'null'
      - string
    doc: can read (tif, tiff, xml)
    inputBinding:
      position: 101
      prefix: PerkinElmer Operetta
  - id: perkinelmer_vectra_qptiff
    type:
      - 'null'
      - string
    doc: can read (tiff, tif, qptiff)
    inputBinding:
      position: 101
      prefix: PerkinElmer Vectra/QPTIFF
  - id: picoquant_bin
    type:
      - 'null'
      - string
    doc: can read (bin)
    inputBinding:
      position: 101
      prefix: PicoQuant Bin
  - id: pict
    type:
      - 'null'
      - string
    doc: can read (pict, pct)
    inputBinding:
      position: 101
      prefix: PICT
  - id: portable_any_map
    type:
      - 'null'
      - string
    doc: can read (pbm, pgm, ppm)
    inputBinding:
      position: 101
      prefix: Portable Any Map
  - id: pov_ray
    type:
      - 'null'
      - string
    doc: can read (df3)
    inputBinding:
      position: 101
      prefix: POV-Ray
  - id: prairie_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff, cfg, env, xml)
    inputBinding:
      position: 101
      prefix: Prairie TIFF
  - id: princeton_instruments_spe
    type:
      - 'null'
      - string
    doc: can read (spe)
    inputBinding:
      position: 101
      prefix: Princeton Instruments SPE
  - id: pyramid_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Pyramid TIFF
  - id: quesant_afm
    type:
      - 'null'
      - string
    doc: can read (afm)
    inputBinding:
      position: 101
      prefix: Quesant AFM
  - id: quicktime
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (mov)
    inputBinding:
      position: 101
      prefix: QuickTime
  - id: rcpnl
    type:
      - 'null'
      - string
    doc: can read (rcpnl)
    inputBinding:
      position: 101
      prefix: RCPNL
  - id: rhk_technologies
    type:
      - 'null'
      - string
    doc: can read (sm2, sm3)
    inputBinding:
      position: 101
      prefix: RHK Technologies
  - id: sbig
    type:
      - 'null'
      - string
    doc: can read ()
    inputBinding:
      position: 101
      prefix: SBIG
  - id: seiko
    type:
      - 'null'
      - string
    doc: can read (xqd, xqf)
    inputBinding:
      position: 101
      prefix: Seiko
  - id: simplepci_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: SimplePCI TIFF
  - id: simulated_data
    type:
      - 'null'
      - string
    doc: can read (fake)
    inputBinding:
      position: 101
      prefix: Simulated data
  - id: slidebook_7_sld_native
    type:
      - 'null'
      - string
    doc: can read (sldy)
    inputBinding:
      position: 101
      prefix: SlideBook 7 SLD (native)
  - id: slidebook_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, tiff)
    inputBinding:
      position: 101
      prefix: Slidebook TIFF
  - id: sm_camera
    type:
      - 'null'
      - string
    doc: can read ()
    inputBinding:
      position: 101
      prefix: SM Camera
  - id: spc_fifo_data
    type:
      - 'null'
      - string
    doc: can read (spc, set)
    inputBinding:
      position: 101
      prefix: SPC FIFO Data
  - id: spcimage_data
    type:
      - 'null'
      - string
    doc: can read (sdt)
    inputBinding:
      position: 101
      prefix: SPCImage Data
  - id: spider
    type:
      - 'null'
      - string
    doc: can read (spi)
    inputBinding:
      position: 101
      prefix: SPIDER
  - id: tagged_image_file_format
    type:
      - 'null'
      - string
    doc: can read, can write, can write multiple (tif, tiff, tf2, tf8, btf)
    inputBinding:
      position: 101
      prefix: Tagged Image File Format
  - id: tecan_spark_cyto
    type:
      - 'null'
      - string
    doc: can read (db)
    inputBinding:
      position: 101
      prefix: Tecan Spark Cyto
  - id: text
    type:
      - 'null'
      - string
    doc: can read (txt, csv)
    inputBinding:
      position: 101
      prefix: Text
  - id: tillvision
    type:
      - 'null'
      - string
    doc: can read (vws, pst, inf)
    inputBinding:
      position: 101
      prefix: TillVision
  - id: topometrix
    type:
      - 'null'
      - string
    doc: can read (tfr, ffr, zfr, zfp, 2fl)
    inputBinding:
      position: 101
      prefix: TopoMetrix
  - id: trestle
    type:
      - 'null'
      - string
    doc: can read (tif)
    inputBinding:
      position: 101
      prefix: Trestle
  - id: truevision_targa
    type:
      - 'null'
      - string
    doc: can read (tga)
    inputBinding:
      position: 101
      prefix: Truevision Targa
  - id: ubm
    type:
      - 'null'
      - string
    doc: can read (pr3)
    inputBinding:
      position: 101
      prefix: UBM
  - id: unisoku_stm
    type:
      - 'null'
      - string
    doc: can read (hdr, dat)
    inputBinding:
      position: 101
      prefix: Unisoku STM
  - id: varian_fdf
    type:
      - 'null'
      - string
    doc: can read (fdf)
    inputBinding:
      position: 101
      prefix: Varian FDF
  - id: veeco
    type:
      - 'null'
      - string
    doc: can read (hdf)
    inputBinding:
      position: 101
      prefix: Veeco
  - id: ventana_bif
    type:
      - 'null'
      - string
    doc: can read (bif)
    inputBinding:
      position: 101
      prefix: Ventana .bif
  - id: vg_sam
    type:
      - 'null'
      - string
    doc: can read (dti)
    inputBinding:
      position: 101
      prefix: VG SAM
  - id: visitech_xys
    type:
      - 'null'
      - string
    doc: can read (xys, html)
    inputBinding:
      position: 101
      prefix: Visitech XYS
  - id: volocity_library
    type:
      - 'null'
      - string
    doc: can read (mvd2, aisf, aiix, dat, atsf)
    inputBinding:
      position: 101
      prefix: Volocity Library
  - id: volocity_library_clipping
    type:
      - 'null'
      - string
    doc: can read (acff)
    inputBinding:
      position: 101
      prefix: Volocity Library Clipping
  - id: wa_technology_top
    type:
      - 'null'
      - string
    doc: can read (wat)
    inputBinding:
      position: 101
      prefix: WA Technology TOP
  - id: windows_bitmap
    type:
      - 'null'
      - string
    doc: can read (bmp)
    inputBinding:
      position: 101
      prefix: Windows Bitmap
  - id: yokogawa_cv7000
    type:
      - 'null'
      - string
    doc: can read (wpi)
    inputBinding:
      position: 101
      prefix: Yokogawa CV7000
  - id: zeiss_axiovision_tiff
    type:
      - 'null'
      - string
    doc: can read (tif, xml)
    inputBinding:
      position: 101
      prefix: Zeiss AxioVision TIFF
  - id: zeiss_czi
    type:
      - 'null'
      - string
    doc: can read (czi)
    inputBinding:
      position: 101
      prefix: Zeiss CZI
  - id: zeiss_laser_scanning_microscopy
    type:
      - 'null'
      - string
    doc: can read (lsm, mdb)
    inputBinding:
      position: 101
      prefix: Zeiss Laser-Scanning Microscopy
  - id: zeiss_lms
    type:
      - 'null'
      - string
    doc: can read (lms)
    inputBinding:
      position: 101
      prefix: Zeiss LMS
  - id: zeiss_vision_image_zvi
    type:
      - 'null'
      - string
    doc: can read (zvi)
    inputBinding:
      position: 101
      prefix: Zeiss Vision Image (ZVI)
  - id: zip
    type:
      - 'null'
      - string
    doc: can read (zip)
    inputBinding:
      position: 101
      prefix: Zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_formatlist.out
