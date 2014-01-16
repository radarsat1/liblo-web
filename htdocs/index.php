<?php
	# Fetch the latest release
/*
	require_once 'magpie/rss_fetch.inc';
	$release_feed = 'http://sourceforge.net/export/rss2_projfiles.php?group_id=116064&rss_limit=1';
	$rss = fetch_rss($release_feed);
	$release = $rss->items[0];
	preg_match("/^liblo ([\d\.]+) released/", $release[title], $matches);
	$release_version = $matches[1]; 
*/
# Note: It seems connections to sourceforge.net are currently refused by
# this script?  Temporarily set the version number manually.

$testing_version = "0.28rc";
$testing_link = "http://downloads.sourceforge.net/liblo/liblo-$testing_version.tar.gz";
$stable_version = "0.26";
$stable_link = "http://downloads.sourceforge.net/liblo/liblo-$stable_version.tar.gz";

	# Because PHP doesn't like parsing xml declaration
	echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
        "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
	<title>liblo: Lightweight OSC implementation</title>
	<style type="text/css">
		h1, h2, h3, h4, h5, h6		
		{
			font-weight: bolder;
			font-family: Helvetica, Geneva, Arial, Verdana, sans-serif;
			padding: 0px;
			margin: 1ex 0px 0ex 0px;
		}
		body		
		{
			width: 640px;
			margin: 20px;
		}
		a { text-decoration: none; }
		a:hover { text-decoration: underline; }
        address        
        {
        	text-align: right;
        	font-size: 10pt;
        	font-style: italic;
        }
		img { border: none; }
	</style>
</head>

<body>
 
<h1>liblo: Lightweight OSC implementation</h1>
<p>
	liblo is an implementation of the 
	<a href="http://www.opensoundcontrol.org/">
		Open Sound Control
	</a>
	protocol for POSIX systems, started by 
	<a href="http://www.plugin.org.uk/"> Steve Harris</a>
	and now maintained by 
	<a href="http://www.music.mcgill.ca/~sinclair">Stephen Sinclair</a>.
	It is released under the 
	<a href="http://www.gnu.org/licenses/lgpl-2.1.txt">GNU Lesser General Public Licence version 2.1 or greater</a>.
	
	This means that if it is included in closed-source systems, it must be dynamically
        linked such that the LibLO code remains freely modifiable.
</p>



<h2>Documentation</h2>
<p>
	You can read 
	<a href="docs/modules.html">
		HTML API documentation online
	</a>
	or look at 
	<a href="examples/">example code</a>.
	Man pages and PostScript docs can be built from the source tarball using doxygen.
</p>

	<ul>
	<li><a href="README.html">README</a>
	<li><a href="NEWS.html">Release Notes</a>
	<li><a href="ChangeLog.html">ChangeLog</a>
	<li><a href="README-platforms.html">Notes on building for other platforms (Windows, Android)</a>
	</ul>

<h2>Download</h2>
<ul>
	<li>Latest stable release: <a href="<?=$stable_link?>">liblo <?=$stable_version?></a></li>
	<li>Latest testing release: <a href="<?=$testing_link?>">liblo <?=$testing_version?></a></li> (Maintainers of projects and distros that use liblo, please test and report any bugs found.)</li>
	<li><a href="http://sourceforge.net/project/showfiles.php?group_id=116064&amp;package_id=177607">Old Releases</a></li>
	<!--<li><a href="http://packages.debian.org/liblo0">Debian Packages</a></li>-->
</ul>

<h2>Site Map</h2>
<ul>
	<li><a href="http://sourceforge.net/projects/liblo/">SourceForge Project Page</a></li>
	<li><a href="http://lists.sourceforge.net/lists/listinfo/liblo-devel">Mailing List</a></li>
	<li><a href="http://sourceforge.net/tracker/?group_id=116064&amp;atid=673869">Bug Tracker</a></li>
	<!--<li><a href="http://sourceforge.net/svn/?group_id=116064">Subversion</a> | <a href="http://svn.sourceforge.net/liblo/">ViewVC</a> |-->
	<li><a href="http://liblo.git.sourceforge.net/git/gitweb.cgi?p=liblo/liblo;a=tree">View Git</a><br/> |
	clone: <tt>git://liblo.git.sourceforge.net/gitroot/liblo/liblo</tt><br/> |
        mirror: <tt>git://gitorious.org/liblo/mainline.git</tt><br/> |
        mirror: <tt>git://github.com/radarsat1/liblo.git</tt></li>

	<li><a href="http://search.cpan.org/dist/Net-LibLO/">Net::LibLO Perl Module</a></li>
	<li><a href="http://das.nasophon.de/pyliblo/">pyliblo - liblo for Python</a></li>
</ul>


<hr />

<address>
<a	href="http://validator.w3.org/check?uri=referer"><img
	src="http://www.w3.org/Icons/valid-xhtml11" 
	alt="Valid XHTML 1.1!" height="31" width="88" /></a>

&nbsp;

<a      href="http://sourceforge.net/projects/liblo"><img
        src="http://sflogo.sourceforge.net/sflogo.php?group_id=116064&type=16"
        width="150" height="40" border="0"
        alt="Get LibLO at SourceForge.net. Fast, secure and Free Open Source software downloads" /></a>
</address>

</body>
</html>
