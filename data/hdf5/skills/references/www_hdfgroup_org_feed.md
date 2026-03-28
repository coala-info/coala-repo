xml version="1.0" encoding="UTF-8"?

The HDF Group – ensuring long-term access and usability of HDF data and supporting users of HDF technologies

https://www.hdfgroup.org/
The HDF Group is a not-for-profit corporation with the mission of sustaining the HDF technologies and supporting HDF user communities worldwide with production-quality software and services.
Fri, 13 Mar 2026 14:43:58 +0000
en-US

hourly

1
https://wordpress.org/?v=6.8.2

https://www.hdfgroup.org/wp-content/uploads/2024/05/cropped-android-chrome-512x512-1-32x32.png
The HDF Group – ensuring long-term access and usability of HDF data and supporting users of HDF technologies
https://www.hdfgroup.org/
32
32

Release of HDF5 2.1.0 (Newsletter #209)
https://www.hdfgroup.org/2026/03/10/release-of-hdf5-2-1-0-newsletter-209/
https://www.hdfgroup.org/2026/03/10/release-of-hdf5-2-1-0-newsletter-209/#respond
loricooper
Tue, 10 Mar 2026 00:01:14 +0000
New Releases
The HDF Group News
hdf5 release
https://www.hdfgroup.org/?p=26541
<p>Following the major milestone of HDF5 2.0.0, we are pleased to announce the release of HDF5 2.1.0. As the first minor release in the 2.x series, version 2.1.0 focuses on expanding support for modern hardware datatypes and improving the developer experience for Fortran users. The HDF5 2.1.0 release is now available from the HDF5 2.1.0 [&#8230;]</p>
<p>The post <a href="https://www.hdfgroup.org/2026/03/10/release-of-hdf5-2-1-0-newsletter-209/">Release of HDF5 2.1.0 (Newsletter #209)</a> appeared first on <a href="https://www.hdfgroup.org">The HDF Group - ensuring long-term access and usability of HDF data and supporting users of HDF technologies</a>.</p>
<p>Following the major milestone of HDF5 2.0.0, we are pleased to announce the release of <strong>HDF5 2.1.0</strong>. As the first minor release in the 2.x series, version 2.1.0 focuses on expanding support for modern hardware datatypes and improving the developer experience for Fortran users.</p>
<p>The HDF5 2.1.0 release is now available from the <a href="https://www.hdfgroup.org/download-hdf5/">HDF5 2.1.0 download page</a>.</p>
<h4><strong>What’s New in 2.1.0</strong></h4>
<p>This release introduces targeted features that enhance performance and compatibility for AI and high-performance computing (HPC) workflows.</p>
<ul>
<li><strong>Improved I/O performance on chunked datasets for specific cases:</strong> HDF5’s data sieving functionality has been enabled when performing I/O on dataset chunks that aren’t cached, significantly improving performance for specific I/O patterns and chunk sizes.</li>
<li><strong>Support for New Low-Precision Datatypes (FP4 and FP6):</strong> Continuing our commitment to modern AI/ML workflows, HDF5 2.1.0 adds predefined datatypes for 4-bit and 6-bit floating-point formats.
<ul>
<li><strong>FP6</strong>: Support for E2M3 and E3M2 formats.</li>
<li><strong>FP4</strong>: Support for the E2M1 format.</li>
<li><em>Note</em>: Conversions are currently emulated in software, providing immediate compatibility for specialized hardware buffers.</li>
</ul>
</li>
<li><strong>Expanded Fortran Support for SWMR:</strong> We have added new Fortran wrappers that provide direct access to Single Writer Multiple Reader (SWMR) functionality, including:
<ul>
<li><code>h5fstart\_swmr\_write\_f</code> to enable SWMR mode.</li>
<li><code>h5dflush\_f</code> and append flush property wrappers to manage data consistency during concurrent access.</li>
</ul>
</li>
<li><strong>Fixed three critical CVEs</strong> that lead to heap-based buffer overflows\*.
<ul>
<li><a href="https://www.cve.org/CVERecord?id=CVE-2025-2309">CVE-2025-2309</a>, a critical vulnerability affecting the function <code>H5T\_\_bit\_copy</code> of the component Type Conversion Logic.</li>
<li><a href="https://www.cve.org/CVERecord?id=CVE-2025-2308">CVE-2025-2308</a>, another critical vulnerability affecting the function <code>H5Z\_\_scaleoffset\_decompress\_one\_byte</code> of the component Scale-Offset Filter.</li>
<li><a href="https://nvd.nist.gov/vuln/detail/CVE-2025-44904">CVE-2025-44904</a>, another vulnerability in the <code>H5VM\_memcpyvv</code> function.</li>
</ul>
</li>
<li><strong>Improved support for libaec detection:</strong> We have added a new CMake module to improve finding libaec compression libraries on the system.</li>
<li><strong>Maintenance &amp; Stability</strong>: This release includes various bug fixes and stability improvements discovered during the rollout of 2.0.0. We have also addressed specific platform issues, including fixing issues with complex number support detection for MSVC.</li>
</ul>
<h4>Migration &amp; Compatibility</h4>
<p>As a minor release, HDF5 2.1.0 is backward compatible with 2.0.0. It continues the transition to <strong>CMake-only builds</strong>, so users who have not yet migrated their build scripts from Autotools should refer to our <a href="https://github.com/HDFGroup/hdf5/blob/2.1.0/release\_docs/HDF5\_Library\_2.0.0\_Migration\_Guide.md">2.0.0 Migration Guide</a>.</p>
<p><strong>Key Links:</strong></p>
<ul>
<li><a href="https://github.com/HDFGroup/hdf5/blob/2.1.0/release\_docs/CHANGELOG.md">Full CHANGELOG</a></li>
<li><a href="https://github.com/HDFGroup/hdf5/blob/2.1.0/release\_docs/README.md">README</a> (includes release schedule)</li>
<li><a href="https://forum.hdfgroup.org/">Support Forum</a></li>
</ul>
<p>We would like to thank the community members whose contributions and feedback helped shape this update. If you have questions, please contact us at <a href="mailto:help@hdfgroup.org">help@hdfgroup.org</a>.</p>
<p><small>\* This material is based upon work supported by the U.S. National Science Foundation under Federal Award No. 2534078. Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.</small></p>
<p>The post <a href="https://www.hdfgroup.org/2026/03/10/release-of-hdf5-2-1-0-newsletter-209/">Release of HDF5 2.1.0 (Newsletter #209)</a> appeared first on <a href="https://www.hdfgroup.org">The HDF Group - ensuring long-term access and usability of HDF data and supporting users of HDF technologies</a>.</p>
https://www.hdfgroup.org/2026/03/10/release-of-hdf5-2-1-0-newsletter-209/feed/
0
26541

​Release of HDFView 3.4.1 (Newsletter #208)
https://www.hdfgroup.org/2026/01/30/release-of-hdfview-3-4-1-newsletter-208/
https://www.hdfgroup.org/2026/01/30/release-of-hdfview-3-4-1-newsletter-208/#respond
loricooper
Fri, 30 Jan 2026 03:33:28 +0000
The HDF Group News
HDFView
hdfview release
https://www.hdfgroup.org/?p=26483
<p>The HDFView 3.4.1 release is now available from the HDFView download page. With this new maintenance release, HDFView now has the following new features: Added comprehensive support for operating with float16 datatypes New user option for editing the plugin path and managing plugins The build system has been converted to Maven A bug fix to [&#8230;]</p>
<p>The post <a href="https://www.hdfgroup.org/2026/01/30/release-of-hdfview-3-4-1-newsletter-208/">​Release of HDFView 3.4.1 (Newsletter #208)</a> appeared first on <a href="https://www.hdfgroup.org">The HDF Group - ensuring long-term access and usability of HDF data and supporting users of HDF technologies</a>.</p>
<p>The HDFView 3.4.1 release is now available from the <a href="https://www.hdfgroup.org/download-hdfview/">HDFView download</a> page.</p>
<p>With this new maintenance release, HDFView now has the following new features:</p>
<ul>
<li>Added comprehensive support for operating with float16 datatypes</li>
<li>New user option for editing the plugin path and managing plugins</li>
<li>The build system has been converted to Maven</li>
<li>A bug fix to end crashes on NETCDF-4 grids</li>
</ul>
<p>HDFView 3.4.1 was</p>
<ul>
<li>built and tested with HDF 4.3.1 and HDF5 2.0.0,</li>
<li>built and tested with OpenJDK 21,</li>
<li>uses Java modules for improved modularity, and</li>
<li>utilizes newest <code>jpackage</code> for distribution.</li>
</ul>
<p>Matt Larson will be taking over as chief product owner/developer of HDFView following Allen Byrne’s retirement at the end of last year.</p>
<p>Please see the <a href="https://github.com/HDFGroup/hdfview/blob/v3.4.1/docs/UsersGuide/CHANGELOG.md"><code>CHANGELOG</code></a> for detailed information regarding this release, including a detailed list of changes. As always, feel free to post on the <a href="https://forum.hdfgroup.org/c/hdfview-java-hdf-object-package">forum</a> with any questions.</p>
<p>The post <a href="https://www.hdfgroup.org/2026/01/30/release-of-hdfview-3-4-1-newsletter-208/">​Release of HDFView 3.4.1 (Newsletter #208)</a> appeared first on <a href="https://www.hdfgroup.org">The HDF Group - ensuring long-term access and usability of HDF data and supporting users of HDF technologies</a>.</p>
https://www.hdfgroup.org/2026/01/30/release-of-hdfview-3-4-1-newsletter-208/feed/
0
26483

Safety, Security, and Privacy in HDF5: A Shared Vocabulary
https://www.hdfgroup.org/2026/01/26/safety-security-and-privacy-in-hdf5-a-shared-vocabulary/
https://www.hdfgroup.org/2026/01/26/safety-security-and-privacy-in-hdf5-a-shared-vocabulary/#respond
loricooper
Mon, 26 Jan 2026 15:39:30 +0000
The HDF Group News
building hdf5
HDF5 SHINES
NSF
Privacy
SAFE-OSE
Safety
security
The HDF Group
https://www.hdfgroup.org/?p=26460
<p>TL;DR Use three tags when you talk about risk in the HDF5 ecosystem—impact (Safety / Security / Privacy), incident lens (Accident / Attack / Exposure), and location (FMT / LIB / EXT / TCD / OPS / PRV / SCD / UNK).</p>
<p>The post <a href="https://www.hdfgroup.org/2026/01/26/safety-security-and-privacy-in-hdf5-a-shared-vocabulary/">Safety, Security, and Privacy in HDF5: A Shared Vocabulary</a> appeared first on <a href="https://www.hdfgroup.org">The HDF Group - ensuring long-term access and usability of HDF data and supporting users of HDF technologies</a>.</p>
<h4>by Gerd Heber, Executive Director, The HDF Group</h4>
<div class="emphasis-box">
<p><strong>TL;DR</strong> Use three tags when you talk about risk in the HDF5 ecosystem—impact (Safety / Security / Privacy), incident lens (Accident / Attack / Exposure), and location (FMT / LIB / EXT / TCD / OPS / PRV / SCD / UNK).</p>
<ul>
<li>This keeps discussions precise: we can separate what happened from where the weakness lives.</li>
<li>It improves triage: the right mitigation for a file-format ambiguity (FMT) is different than for a supply-chain weakness (SCD) or an operational misconfiguration (OPS).</li>
<li>Overlaps are expected—tag multiple categories when needed. The goal is coordination, not perfect taxonomy.</li>
</ul>
</div>
<p>Open-source data infrastructure has become part of our critical infrastructure. HDF5 sits in the middle of many scientific and industrial workflows, so failures can have wide blast radii—from silent data corruption, to denial-of-service in shared environments, to unintended disclosure of sensitive metadata.</p>
<p>In the NSF Safe-OSE framing, “risk” spans safety, security, and privacy (not security alone) and includes both technical and socio‑technical vulnerabilities. In our HDF5 SHINES (<strong>S</strong>ecuring <strong>H</strong>DF5 for <strong>I</strong>ndustry, and <strong>N</strong>ational Security, <strong>E</strong>ngineering, and <strong>S</strong>cience) effort, we’re adopting that posture with a very practical goal: a shared vocabulary that helps the community spot patterns, assign ownership, and prioritize engineering and operational work.</p>
<h3>Why we keep saying “Safety, Security, and Privacy” (SSP)</h3>
<p>In many contexts, “security” becomes shorthand for everything bad that can happen. For HDF5, that shortcut gets in the way of effective mitigation because it blurs three different kinds of harm:</p>
<ul>
<li>Accidents: unintentional failures (corrupted files, brittle integrations, unexpected edge cases).</li>
<li>Attacks: intentional adversarial actions (malicious files, compromised plugins, hostile environments).</li>
<li>Exposures: unintended disclosure of sensitive information (metadata leakage, re-identification risk, operational leakage).</li>
</ul>
<p>By naming all three, we can be explicit about intent and impact—without arguing about whether something “counts” as a security issue.</p>
<h3>Safety vs. security vs. privacy in HDF5</h3>
<p>These are pragmatic definitions meant to help engineers and users communicate clearly. They are not meant to replace formal standards; they are meant to make day-to-day triage easier.</p>
<h4>Safety: preventing harm from accidents and failures</h4>
<p>Safety issues are failures that cause harm without requiring an adversary. In HDF5, “harm” often looks like:</p>
<ul>
<li>Wrong scientific conclusions due to corrupted or misinterpreted data.</li>
<li>Crashes or hangs in critical pipelines.</li>
<li>Resource exhaustion that takes down shared infrastructure.</li>
</ul>
<p>Typical HDF5-flavored safety examples:</p>
<ul>
<li>A corrupted HDF5 file (truncated transfer, disk error) causes a reader to crash or hang instead of failing cleanly.</li>
<li>A valid but extreme file layout triggers pathological CPU/memory behavior (e.g., runaway recursion or huge metadata traversal).</li>
<li>A filter or plugin misbehaves and silently produces incorrect output.</li>
</ul>
<p>Safety is where robustness, correctness, and resilience to weird (but non-adversarial) inputs live.</p>
<h4>Security: resisting attacks</h4>
<p>Security issues assume intent: someone crafts inputs or manipulates the environment to produce an outcome they want (code execution, data tampering, denial-of-service, privilege escalation).</p>
<p>Typical HDF5-flavored security examples:</p>
<ul>
<li>A crafted HDF5 file exploits a parsing weakness to crash an application or trigger arbitrary code execution.</li>
<li>A malicious or compromised VOL/VFD/filter plugin runs with the privileges of the host process and can do much more than “I/O.”</li>
<li>A compromised distribution channel or build pipeline results in trojanized binaries or plugins.</li>
</ul>
<h4>Privacy: controlling unintended disclosure</h4>
<p>Privacy issues are about sensitive information being exposed—whether through design gaps, metadata leakage, misuse, or side effects. Privacy is not only about encryption; it’s also about what leaks through structure, names, defaults, logs, and operational practice.</p>
<p>Typical HDF5-flavored privacy examples:</p>
<ul>
<li>Sensitive identifiers embedded in group names, attributes, or link metadata are shared “in plain sight.”</li>
<li>A workflow encrypts only the raw data while leaving identifying metadata readable and linkable.</li>
<li>Extensions leak sensitive state through side effects, logs, or metadata manipulation.</li>
</ul>
<h3>The “SSP Trident” mental model</h3>
<p>To keep conversations grounded, we use a simple mental model: separate (1) the kind of incident we care about from (2) where the weakness 