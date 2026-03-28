Track attributes

Each track has a set of attributes that varies depending on the track type. For example, alignment tracks have attributes that are specific to the display of the read alignments. Some attributes are common across track types. For example, all tracks have a track name.

# Setting track attributes[#](#setting-track-attributes "Direct link to this section")

Many of the track attributes are also user settable:

To **set a attribute value for a specific track**, right-click on the track (either in the data panel or the track name) to bring up a pop-up menu that is specific to the track type.

Some attributes can be set on multiple tracks at the same time. First, select all the tracks of interest and then right click on one of them to bring up the pop-up menu. You can select multiple tracks either by using the normal multi-select mouse actions (e.g. `Ctrl-click` on Windows; `Cmd-click` on MacOS) or by clicking an attribute in the [sample attribute panel](../../sample_attributes/) to select all tracks tagged with that attribute value.

Select *View > Preferences* to **change the default value for an attribute** for a particular track type. Not all default values are user settable.

In some cases, attribute values can be set via actions in the main IGV menu.

# Common track attributes[#](#common-track-attributes "Direct link to this section")

## Track color[#](#track-color "Direct link to this section")

To change the color for tracks displayed as a heatmap:

* Right-click the track and select *Set Heatmap Scale...* from the pop-up menu.

To change the color for tracks that are displayed as something other than a heatmap (e.g, bar chart, scatter plot, line plot, alignments):

* Right-click the track and from the pop-up menu select either *Change Track Color...* or *Change Track Color (Negative Values or Strand)...*.

## Track height[#](#track-height "Direct link to this section")

To change the height of **selected** tracks:

* Select *Change Track Height...* from the track pop-up menu.

To change the height of **all** tracks:

* Select *Tracks > Set Track Height...* in the main IGV menu.

To change the **default height** of tracks:

* The *Tracks* tab in *View > Preferences* has fields to set the default height for numeric/quantitative tracks and for feature/genome annotation tracks.

## Track name[#](#track-name "Direct link to this section")

Tracks are assigned default names, typically based on the file name or the names of samples contained in the file.

If you have loaded [sample attributes](../../sample_attributes/), you can specify an attribute to define the **default track name**:

* Enter the sample attribute name in the field *Sample attribute key for track names* in *View > Preferences > Tracks*.

To set a track name to a **specific string**:

* Right-click the track, then select *Rename Track...* in the pop-up menu. You can only rename one track at a time.

The track names are displayed in a panel to the left the track data, and to the left of the sample attribute panel if it is displayed.

* To **hide the name panel**, unselect *View > Show Name Panel*.
* To **resize the name panel**, select *View > Set Name Panel Width...*