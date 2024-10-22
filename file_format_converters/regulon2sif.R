# usage: Rscript regulon2sif.R regulon.RData out.sif
# regulon.RData is a rdata file thats contain only a Regulon object generated from ssmarina

args <- commandArgs(trailingOnly = TRUE);

rdata = args[1];
outfile = args[2]
print(outfile);

load(rdata);
regulon = get(ls()[2]);


for (name in names(regulon)) {
    source = rep(name, length(regulon[[name]]$tfmod));
    sif    = cbind(source, names(regulon[[name]]$tfmod), regulon[[name]]$tfmod);
    write.table(sif, file = outfile, append = TRUE, quote = FALSE, sep = "\t", col.names=FALSE, row.names=FALSE);
}


