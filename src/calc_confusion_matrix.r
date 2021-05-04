evaluate <- function(dataset) {
  library(caret) # include library
  
  dt <- read.table(dataset, header = TRUE, sep="\t")  # load table
  
  # extract file name, for naming output and rowname
  f_name <- paste0(tools::file_path_sans_ext(dataset))
  
  # define variable for confusion matrix
  lvs = c("secreted","other")
  actual = factor(dt$y_true, levels = lvs)
  pred = factor(dt$y_pred, levels = lvs)
  
  # calculate confusion matrix
  eval_indices <- confusionMatrix(pred, actual)
  
  # convert to tables
  conf_matrix <- as.data.frame(eval_indices$table)
  eval_table <- t(as.data.frame(eval_indices$byClass, row.names = NULL))
  rownames(eval_table) <- f_name
  
  # ---------- calculate FDR -------------------
  False.Discovery.Rate <- 1 - eval_table[3]
  eval_table <- data.frame(eval_table,False.Discovery.Rate)
  
  # --------- calculate MCC ----------
  library(mccr)
  mcc_sp_alone <- mccr(dt$mcc_y_true,dt$mcc_y_pred)
  mcc_to_table <- as.data.frame(mcc_sp_alone)
  colnames(mcc_to_table) <- "MCC"
  
  
  # merge eval table with MCC
  eval_table <- data.frame(eval_table,mcc_to_table)
  
  # export tables
  f1 <- write.table(eval_table,file = sprintf("%s_evaluation_table.tsv",f_name), 
                    sep="\t",eol = "\n")
  f2 <- write.table(conf_matrix,file = sprintf("%s_confusion_matrix.tsv",f_name), 
                    sep ="\t",eol = "\n")
  
  # return the value
  return(paste(f_name,"evaluation is completed!"))
}







