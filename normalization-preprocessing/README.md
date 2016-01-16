# Preprocessing and normalization of microarray samples

Four steps to go from .CEL expression arrays files, to a preprocessed and normalized ready to an ARACNe expression matrix.

1. Install dependecies (no arguments needed).

		Rscript install_dependencies.R

2. Summarization and first normalization of the .CEl files with Frozen RMA ([frma](https://www.bioconductor.org/packages/release/bioc/html/frma.html)) in one or more folders.

		Rscript frma_normalizer.R --celfolder proof_set/ --bgcorrect rma --normalize quantile --summarize robust_weighted_average --matrix proofset.txt
			
	+ **celfolder**: one or more folders with .CEL files (required)
	+ **bgcorrect**: type of background correction: rma (default) on none
	+ **normalize**: type of normalization: quantile (default) on none
	+ **sumarize**: type of summarization: robust_weighted_average (default), one of  median_polish, average, median, weighted_average, random_effect
	+ **matrix**: normalized expression matrix output (required)

	
3. Batch effect correction using ComBat ([sva](https://www.bioconductor.org/packages/release/bioc/html/sva.html)).

			Rscript ComBat_correction.R --matrix proofset.txt --phenotype proof_set/phenotype_file.txt --output proofset_noBE.txt

	+ **matrix**: normalized expression matrix input to correct (required)
	+ **phenotype**: phenotype data (required)
	+ **output**: batch effect corrected output matrix (required)
				
4. Annotate and collapse the expresion matrix by gene symbols using B statistical or by means. (It requires internet connection.)

			Rscript B_collapser.R --matrix proofset_noBE.txt --phenotype proof_set/phenotype_file.txt --collapse B --case case --control control --phatifier no
				
	+ **matrix**: expression matrix to callapse  (required)
	+ **phenotype**: phenotype data  (required)
	+ **collapse**: you can select the type of collapse by B statistic or means (default: B)
	+ **case**: name of cases samples in the output column in the phenotype file (default: case)
	+ **control**: name of control samples in the output column in the phenotype file (default: control)
	+ **pathifier**: if you need a matrix ready for pathfier with the first line indicating the cases and controls with zeros and ones, put yes in this option. (default: no)
	
	
The resulting matrix can be the input of "[parallel_aracne](/parallel_aracne)" module or the "[Pathifier_tool_kit](/Pathifier-Tool-Kit)" module.