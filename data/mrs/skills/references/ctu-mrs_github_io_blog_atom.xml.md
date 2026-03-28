xml version="1.0" encoding="utf-8"?xml-stylesheet type="text/xsl" href="atom.xsl"?

https://ctu-mrs.github.io/blog
CTU MRS Documentation Blog
2024-12-18T00:00:00.000Z
https://github.com/jpmonette/feed

CTU MRS Documentation Blog
https://ctu-mrs.github.io/img/favicon.ico

Update for accurate AMSL altitude positioning
https://ctu-mrs.github.io/blog/accurate-amsl-altitude

2024-12-18T00:00:00.000Z
We have implemented a major update in the MRS System, which changes how the AMSL (Above Mean Sea Level) altitude is calculated and used in the MRS system.
<p>We have implemented a major update in the MRS System, which changes how the AMSL (Above Mean Sea Level) altitude is calculated and used in the MRS system.
The update allows to fly to the exact AMSL altitude when using the RTK state estimator.</p>
<p>So far, the AMSL transformations (amsl\_origin, utm\_origin) published by <code>transform\_manager</code> were based on the topic <code>hw\_api/altitude</code>, which was based on the GNSS altitude reported by mavros/pixhawk.
Now, when RTK is available (it is in the list of state estimators in custom config), the RTK altitude will be used instead.
The altitude is using the TF <code>fcu -&gt; rtk\_antenna</code> to transform the measurements received by the antenna into the fcu frame, which is typically offset vertically on the drones.
The <code>fcu -&gt; rtk\_antenna</code> TF was previously published from <code>sensors.launch</code> but I deleted the TF from the launch file because it is drone-specific and thus is the responsibility of the user to provide them in the tmux session. If the tf is not provided, transform manager will crash and inform the user to provide the tf.</p>
<p>Affected TFs:</p>
<ul>
<li class=""><code>fcu -&gt; amsl\_origin</code> - Contains only the AMSL altitude (no XY position or orientation).</li>
<li class=""><code>fcu -&gt; utm\_origin</code> - Contains the AMSL altitude, the XY position in the UTM frame (LatLon converted to meters), and the orientation.</li>
</ul>
<p>EMLID uses the WGS84 ellipsoid model for altitude and we don't do any conversion, so our altitude is also in WGS84. Pixhawk uses geographiclib to convert GNSS WGS84 data into some geoid model (one of EGM2008, EGM96, EGM84), so the altitude in <code>hw\_api/gnss</code> (pixhawk) and <code>hw\_api/rtk</code> (EMLID) will differ by tens of meters (depending on the location).</p>
<p>This update concerns only EMLID RTK receivers. Flying with Holybro F9P had already accurate AMSL positioning and is not affected by this update as it is connected into pixhawk and not into NUC.</p>
<p>The update is currently on the Unstable PPA and master branch and coming to stable in the next release.</p>

Matej Petrlik
https://github.com/petrlmat

Documentation migrated to docusaurus
https://ctu-mrs.github.io/blog/new-documentation

2024-11-13T00:00:00.000Z
We have moved the docs to docusaurus.
<p>We have moved the docs to <code>docusaurus</code>.
This will allow us to properly <strong>version the docs</strong> and keep the version history.
Thanks to this, the users should be able to find the right docs for the current version of the system they are using.</p>

Tomas Baca
https://github.com/klaxalk