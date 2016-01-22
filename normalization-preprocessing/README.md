# Preprocessing and normalization of microarray samples

Four steps to go from .CEL expression arrays files, to a preprocessed and normalized ready to an ARACNe expression matrix. This module includes a test set in the folder [proof_set](/normalization-preprocessing/proof_set/). The file [phenotype_file.tsv](https://github.com/CSB-IG/rnw/blob/master/normalization-preprocessing/proof_set/phenotype_file.tsv) is an example of the phenotype data file required.

###1. Install dependecies (no arguments needed).

		Rscript install_dependencies.R

###2. Summarization and first normalization of the .CEl files with Frozen RMA ([frma](https://www.bioconductor.org/packages/release/bioc/html/frma.html)) in one or more folders.

		Rscript frma_normalizer.R \
			--celfolder proof_set/ \
			--bgcorrect rma \
			--normalize quantile \
			--summarize robust_weighted_average \
			--matrix proofset.txt
			
	+ **celfolder**: one or more folders with .CEL files (required)
	+ **bgcorrect**: type of background correction: "rma" (default) on "none"
	+ **normalize**: type of normalization: "quantile" (default) on "none"
	+ **sumarize**: type of summarization: "robust_weighted_average" (default), "median", "median_polish", "average" or "random_effect"
	+ **matrix**: normalized expression matrix output (required)

	
###3. Batch effect correction using ComBat ([sva](https://www.bioconductor.org/packages/release/bioc/html/sva.html)).

			Rscript ComBat_correction.R \
				--matrix proofset.txt \
				--phenotype proof_set/phenotype_file.tsv \
				--output proofset_noBE.txt

	+ **matrix**: normalized expression matrix input to correct (required)
	+ **phenotype**: phenotype data (required)
	+ **output**: batch effect corrected output matrix (required)
				
###4. Annotate and collapse the expresion matrix by gene symbols using B statistical or by means. (It requires internet connection.)

			Rscript collapser.R \
				--matrix proofset_noBE.txt \
				--phenotype proof_set/phenotype_file.tsv \
				--collapse B \
				--case case \
				--control control \
				--phatifier no
				
	+ **matrix**: expression matrix to callapse  (required)
	+ **phenotype**: phenotype data  (required)
	+ **collapse**: you can select the type of collapse by "B" statistic, "medians" or "means" (default: B)
	+ **case**: name of cases samples in the output column in the phenotype file (default: case)
	+ **control**: name of control samples in the output column in the phenotype file (default: control)
	+ **pathifier**: if you need a matrix ready for pathfier with the first line indicating the cases and controls with zeros and ones, put yes in this option. (default: no)
	
	
The resulting matrix can be the input of "[parallel_aracne](https://github.com/CSB-IG/parallel-aracne)" module or the "[Pathifier_tool_kit](https://github.com/AngelCampos/Pathifier-Tool-Kit)" module.



---
---


### Extras

Two additional scripts are in the extras folder:

#### Normalize script

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
#### Heatmap script

Sourcing this script will ask the user for 2 files:

1. An expression matrix: a tab separated .txt file with sample names on 1st row and genes in 1st column.
2. Differential expression genes: A tab separated .txt. file that contains in the first column the names of the selected genes.

Generating a heatmap graphic based on the expression of the sets and by performing unsupervised clustering analysis grouping the samples with a dendrogram.

Here is an example data set that can be used to test the script
[Example-Data](https://dl.dropboxusercontent.com/u/72765415/Example_expression_set.txt "Right click/save link as...")

Sourcing heatmap.R using the example data will generate this heatmap:
![Heatmap](https://dl.dropboxusercontent.com/u/72765415/example_heatmap.png)
---
