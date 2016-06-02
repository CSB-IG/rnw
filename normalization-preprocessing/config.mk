
# phenotype data (required)
PHENOTYPE=proof_set/phenotype_file.tsv 

# normalized expression matrix (required)
MATRIX=proofset.txt


###########################################################
# Summarization and first normalization of the CEL files  #
###########################################################

# One or more folders with .CEL files (required)
CELFOLDER=proof_set/ 

# type of background correction: "rma" (default) on "none"
BGCORRECT=rma

# type of normalization: "quantile" (default) on "none"
NORMALIZE=quantile

# type of summarization: "robust_weighted_average" (default),
# "median", "median_polish", "average" or "random_effect"
SUMMARIZE=robust_weighted_average 



#######################################
# Batch effect correction with ComBat #
#######################################

# batch effect corrected output matrix (required)
NOBATCH_MATRIX=proofset_noBE.txt



###########################################
# Annotate and collapse expression matrix #
###########################################

# matrix input for collapse. by default it uses the batch effect corrected matrix (NOBATCH_MATRIX)
# if you want to skip batch correction use the following line instead:
#
# MATRIX_TO_COLLAPSE=$MATRIX 
#
MATRIX_TO_COLLAPSE=$NOBATCH_MATRIX

# you can select the type of collapse by "B" statistic, "medians" or
# "means" (default: B)
COLLAPSE=B

# name of cases samples in the output column in the phenotype file
# (default: case)
CASE_NAME=case

# name of control samples in the output column in the phenotype file
# (default: control)
CONTROL_NAME=control

# if you need a matrix ready for pathifier with the first line
# indicating the cases and controls with zeros and ones, put yes in
# this option. (default: no)
FOR_PATHIFIER=no
