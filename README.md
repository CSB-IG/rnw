# Regulatory Netkwork Workflow

This is a project to centralize the Workflow for
the [Computational Systems Biology/Integrative Genomics research group at INMEGEN](http://csbig.inmegen.gob.mx/)
in order to reproduce fully or partially previous analysis in new datasets.


For clone this repository and his submodules:

	git clone https://github.com/CSB-IG/rnw.git
	cd rnw/
	git submodule init
	git submodule update


## 1. Download data (implementation pending)

some attempts to automate the downloading of public data.

## 2. Data normalization/preprocessing

Tips and strategies for the preprocessing of genomic expression data.

###➔ Pathifier
[Miguel Angel García-Campos](http://csbig.inmegen.gob.mx/people/angel_campos/) Pathifier enritchment tool kit:  
<https://github.com/AngelCampos/Pathifier-Tool-Kit>


## 3. Network Generation

[CSB-IG group](http://csbig.inmegen.gob.mx/) HTCondor implementation for parallelize [ARACNe's](http://wiki.c2b2.columbia.edu/califanolab/index.php/Software/ARACNE) MI calculation:

<https://github.com/CSB-IG/parallel-aracne>

[Diana Drago García](http://csbig.inmegen.gob.mx/people/diana_drago/) tool kit for to take the parallel aracne output files in to [minet](http://www.bioconductor.org/packages/release/bioc/html/minet.html) to process regulatory networks (eg DPI implementation)

<https://github.com/CSB-IG/miRNAseq_rnw>

## 4. Subsequent spells:

###➔ INFOMAP
Sergio Antonio Alcalá Corona convert a SIF like file to a Pajek like file ready to [INFOMAP](http://www.mapequation.org/apps.html):
<https://github.com/saac/ComplexNetworks-ToolBox>

The INFOMAP output can be analysed with Sergio Antonio Alcalá Corona's enritchment tool kit:
<https://github.com/saac/Enrichmentator>

###➔ Transcriptional Master Regulators search (unfinished)
[Hugo Tovar's](http://csbig.inmegen.gob.mx/people/hugo_tovar/) MARINa tool kit take the TF interactions from ARACNe networks and implement a TMRs search with [ssmarina](https://figshare.com/articles/ssmarina_R_system_package/785718):
 
<https://github.com/CSB-IG/tmr_search>
