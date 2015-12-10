# rnw
**regulation network workflow**



## 1. Download data

some attempts to automate the downloading of public data.

## 2. Data normalization/preprocessing

Tips and strategies for the preprocessing of genomic expression data.

##➔ Pathifier
[Miguel Angel García-Campos](http://csbig.inmegen.gob.mx/people/angel_campos/) Pathifier enritchment tool kit:  
<https://github.com/AngelCampos/Pathifier-Tool-Kit>



## 3. Network Generation

[CSB-IG group](http://csbig.inmegen.gob.mx/) HTCondor implementation for parallelize [ARACNe's](http://wiki.c2b2.columbia.edu/califanolab/index.php/Software/ARACNE) MI calculation:

<https://github.com/CSB-IG/breast_cancer_networks/tree/master/parallel_aracne>

[Diana Drago García](http://csbig.inmegen.gob.mx/people/diana_drago/) tool kit for to take the parallel aracne output files in to [minet](http://www.bioconductor.org/packages/release/bioc/html/minet.html) to process regulatory networks (eg DPI implementation)

<https://github.com/CSB-IG/miRNAseq_rnw/tree/master/RNAseq_networks>

## 4. Subsequent spells:

##➔ INFOMAP
Sergio Antonio Alcalá Corona convert a SIF like file to a Pajek like file ready to [INFOMAP](http://www.mapequation.org/apps.html):
<https://github.com/saac/ComplexNetworks-ToolBox>

The INFOMAP output can be analysed with Sergio Antonio Alcalá Corona's enritchment tool kit:
<https://github.com/saac/Enrichmentator>

##➔ Transcriptional Master Regulators search
[Hugo Tovar's](http://csbig.inmegen.gob.mx/people/hugo_tovar/) MARINa tool kit take the TF interactions from ARACNe networks and implement a TMRs search with [ssmarina](https://figshare.com/articles/ssmarina_R_system_package/785718):
 
<https://github.com/CSB-IG/tmr_search>


## Normalize script

<pre>
rgarcia@notron:~/rnw$ ./normalize_batch.R -h
usage: ./normalize_batch.R [-h] [--bgcorrect {bg.correct,mas,none,rma}]
                           [--normalize {constant,contrasts,invariantset,loess,methods,qspline,quantiles,quantiles.robust}]
                           --matrix MATRIX
                           cel [cel ...]

Normalize CEL files of a same batch.

positional arguments:
  cel                   CEL files to normalize

optional arguments:
  -h, --help            show this help message and exit
  --bgcorrect {bg.correct,mas,none,rma}
                        method for background noise correction
  --normalize {constant,contrasts,invariantset,loess,methods,qspline,quantiles,quantiles.robust}
                        normalizing method
  --matrix MATRIX       normalized expression matrix
</pre>

---
## Heatmap script

Sourcing this script will ask the user for 2 files:

1. An expression matrix: a tab separated .txt file with sample names on 1st row and genes in 1st column.
2. Differential expression genes: A tab separated .txt. file that contains in the first column the names of the selected genes.

Generating a heatmap graphic based on the expression of the sets and by performing unsupervised clustering analysis grouping the samples with a dendrogram.

Here is an example data set that can be used to test the script
[Example-Data](https://dl.dropboxusercontent.com/u/72765415/Example_expression_set.txt "Right click/save link as...")

Sourcing heatmap.R using the example data will generate this heatmap:
![Heatmap](https://dl.dropboxusercontent.com/u/72765415/example_heatmap.png)
---

