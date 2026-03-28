Loading and removing tracks

# Loading tracks[#](#loading-tracks "Direct link to this section")

Tracks can be loaded from local files, URLs, and remote track servers. See [File Formats](../../FileFormats/DataTracks/)
for information about the
file formats IGV accepts for tracks.

To **load tracls from the local file system** or other file systems you have mounted:

1. Select *File > Load from File*. IGV displays the Select Files window.
2. Select one or more data files or sample information files, then click *OK*.

To **load tracks that are accessible via URL** on a local intranet or the internet:

1. Select *File > Load from URL*.
2. Enter the URL for a data file or sample information file; If the file is indexed, make sure to enter the index file
   name in the field provided; Click *OK.*

For BAM, TDF, and indexed file formats the web server must support HTTP byte-range requests.

To **load hosted tracks**:

For some genome assemblies IGV provides access to remotely hosted track files through the "Load Hosted Tracks" menu
item. If hosted tracks are not available for the current genome this menu item will not be available.

1. Select *File > Load Hosted Tracks..*. The Available Datasets window appears. The Available Datasets are specific to
   the current reference genome.
   ![](../img/load_from_server.jpg)
2. Expand the tree to see the datasets; Click the checkboxes to select one or more dataset; Click *OK*.
   !!! tip " "
   Be aware that clicking on a folder checkbox selects all of its subfolders and all of the datasets in those folders.
   This can potentially be a huge amount of data. To be sure you are loading only the data you want, open collapsed
   folders and select only the datasets of interest.

# Removing tracks[#](#removing-tracks "Direct link to this section")

To remove **all** tracks:

* Select *File > New Session*. This is essentially the same as restarting IGV. The reference genome tracks are not
  removed.

To remove **specific** tracks, do one of the following:

* Right-click on a track (either in the data panel or the track name) and select *Remove Tracks* in the pop-up menu.
* Select multiple tracks and then right-click on one of the selected tracks and select *Remove Tracks* in the pop-up
  menu. You can select multiple tracks either by using the normal multi-select mouse actions (e.g. CTRL-click on
  Windows; CMD-click on Mac) or by clicking a sample attribute value to select all tracks tagged with that attribute
  value.