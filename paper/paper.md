---
title: 'bleiglas: An R package for 3D tesselation with voro++ and related analysis operations'
tags:
  - R
  - 3D data analysis
  - Tesselation
  - Voronoi diagrams
  - Spatiotemporal analysis
  - Archaeology
authors:
  - name: Clemens Schmid
    orcid: 0000-0003-3448-5715
    affiliation: 1
  - name: Stephan Schiffels
    orcid: 0000-0002-1017-9150
    affiliation: 1
affiliations:
  - name: Department of Archaeogenetics, Max Planck Institute for the Science of Human History, Kahlaische Strasse 10, 07745 Jena, Germany
    index: 1
date: 07 June 2020
bibliography: paper.bib
---

# Background

The open source software library [voro++](http://math.lbl.gov/voro++)[@Rycroft2009-rp] allows fast calculation of Voronoi diagrams in three dimensions. Voronoi diagrams are a special form of tesselation (i.e. filling space with geometric shapes without gaps or overlaps), where each polygon is defined as the region consisting of all points closest to one particular seed point. Imagine a volume in three dimensional space and an arbitrary distribution of unique points within this volume. voro++ creates a polygon around each point so that everything within this polygon is closest to the corresponding point and farther away from the other starting points.

Voronoi tesselation has useful applications in all kinds of scientific contexts spanning astronomy (e.g. @Paranjape2020-sg) material science (e.g. @Tsuru2020-ep) or geography (e.g. @Liu2019-fw). From the point of view of computational and landscape archaeology delaunay triangulation and voronoi diagrams were as well applied as tools for data analysis [@Nakoinz2016-bq], but so far mostly limited to a entirely spatial 2D perspective. 3D tesselation could as well be employed here to add a third dimension: most intriguingly a temporal one. This could allow for new methods of spatiotemporal data analysis and vizualisation as demonstrated in the example below.

# Core functionality

``bleiglas`` provides the `tesselate` function which is a a command line utility wrapper for voro++. 

# Example: Burial rite distributions in Bronze Age Europe

# Acknowledgements

The package benefitted from valuable input by Joscha Gretzinger.

# References